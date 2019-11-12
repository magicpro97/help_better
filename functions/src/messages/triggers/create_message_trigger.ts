import * as functions from "firebase-functions";
import { DocumentSnapshot, Timestamp } from "@google-cloud/firestore";
import { Message, MessageGroup, User, MessageStatus, FCollection, MemberState } from "../../constants";
import { messaging } from "firebase-admin";

export default function onCreate(cMessaging : messaging.Messaging) {
    return functions.firestore
        .document("message_groups/{messageGroupId}/{messages}/{messageId}")
        .onCreate((snapshot, context) => {
            if (context.params.messages === "messages") {
                updateMessageStatus(snapshot).catch(err => console.log(err));
                notifyToOtherUser(snapshot, cMessaging).catch(err => console.log(err));
                return updateMessageGroup(snapshot);
            }
            return snapshot;
        });
}

const notifyToOtherUser = async (snapshot: DocumentSnapshot, cMessaging: messaging.Messaging) => {
    const newMessage = snapshot.data() as Message;
    const messageGroups = snapshot.ref.parent.parent;
    if (messageGroups) {
        const messageGroup = ((await messageGroups.get()).data() as MessageGroup);
        const memberStatus = messageGroup.memberStatus;
        const app = messageGroups.parent.parent;
        if (app) {
            const uSnap = await app.collection("users").where("id", "in", messageGroup.memberIds).get();
            for (const doc of uSnap.docs) {
                const user = doc.data() as User;
                const tokens = user.tokens;
                if (tokens && 
                    user.id !== newMessage.userId && 
                    (memberStatus[user.id] !== MemberState.IN || !user.online)) {
                        const token = tokens.pop();
                        const owner = (await app.collection("users").doc(newMessage.userId).get()).data() as User;
                        if (token) {
                            const payload: messaging.MessagingPayload = {
                                notification: {
                                title: owner.displayName,
                                body: newMessage.content,
                                icon: user.photoUrl,
                                click_action: 'FLUTTER_NOTIFICATION_CLICK' // required only for onResume or onLaunch callbacks
                                }
                            };
                            await cMessaging.sendToDevice(token, payload);
                        }
                }
            }
        }
    }
    return snapshot;
}

const updateMessageGroup = (snapshot: DocumentSnapshot) => {
    const createTime = snapshot.createTime;
    if (snapshot.ref.parent.parent !== null) {
        const doc = snapshot.ref.parent.parent;
        return doc
            .update({
                updated: createTime
            })
            .catch(err => console.log(err));
    }
    return snapshot;
};

const updateMessageStatus = async (snapshot: FirebaseFirestore.DocumentSnapshot) => {
    if (snapshot.exists) {
        const message = snapshot.data() as Message;
        if (message) {
            const mGSnap = snapshot.ref.parent.parent;
            const userId = message.userId;
            const messageStatus = message.status;
            if (mGSnap) {
                const { SENT, SEEN, RECEIVED } = MessageStatus;
                const mGDoc = await mGSnap.get();
                const messageGroup = mGDoc.data() as MessageGroup;
                const memberStatus = messageGroup.memberStatus;
                const memberIds = messageGroup.memberIds;
                const friendIds = memberIds.filter((id) => id !== userId);
                messageStatus[userId] = SENT;
                for (const friendId of friendIds) {
                    const memberState = memberStatus[friendId];
                    if (memberState === MemberState.IN) {
                        messageStatus[friendId] = SEEN;
                    } else {
                        const app = mGDoc.ref.parent.parent;
                        if (app) {
                            const uSnap = await app.collection(FCollection.USERS).where("id", "in", friendIds).get();
                            for (const uDoc of uSnap.docs) {
                                const user = uDoc.data() as User;
                                if (user.online) {
                                    messageStatus[user.id] = RECEIVED;
                                } else {
                                    messageStatus[user.id] = SENT;
                                }
                            }
                        }

                    }
                    const newStatus = messageStatus;
                    return snapshot.ref
                        .update({
                            status: newStatus,
                            updated: Timestamp.now(),
                        })
                        .catch(err => console.log(err));
                }
                return snapshot;
            }
        };
    }
}
