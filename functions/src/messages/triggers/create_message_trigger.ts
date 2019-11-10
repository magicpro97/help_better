import * as functions from "firebase-functions";
import { DocumentSnapshot, Timestamp } from "@google-cloud/firestore";
import { Message, MessageGroup, User, MessageStatus, FCollection, MemberState } from "../../constants";

export default function onMessageCreate() {
    return functions.firestore
        .document("message_groups/{messageGroupId}/{messages}/{messageId}")
        .onCreate((snapshot, context) => {
            if (context.params.messages === "messages") {
                updateMessageStatus(snapshot).catch(err => console.log(err));
                return updateMessageGroup(snapshot);
            }
            return snapshot;
        });
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
