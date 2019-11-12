import * as functions from "firebase-functions";
import { DocumentReference, Timestamp } from "@google-cloud/firestore";
import { FCollection, User, MessageGroup, Message, MessageStatus } from "../../constants";

export default function onUserStateChange() {
    const { USERS, MESSAGES, MESSAGE_GROUPS } = FCollection;
    return functions.firestore
        .document(`${USERS}/{userId}`)
        .onWrite((change, _) => {
            const user = change.after.data() as User;
            if (user) {
                const app = (change.after.ref.parent.parent as DocumentReference)
                const { SENT, RECEIVED } = MessageStatus;
                return app.collection(`${MESSAGE_GROUPS}`).where("memberIds", "array-contains", user.id).get().then(async (mGSnap) => {
                    for (const mGDoc of mGSnap.docs) {
                        const messageGroup = mGDoc.data() as MessageGroup;
                        if (user.online) {
                            const friendIds = messageGroup.memberIds.filter((id) => id !== user.id);
                            const mSnap = await mGDoc.ref.collection(`${MESSAGES}`).where("userId", "in", friendIds).get();
                            for (const mDoc of mSnap.docs) {
                                const message = mDoc.data() as Message;
                                if (message.status[user.id] === SENT) {
                                    message.status[user.id] = RECEIVED;
                                    mDoc.ref.update({
                                        status: message.status,
                                        updated: Timestamp.now(),
                                    }).catch(err => console.log(err))
                                }
                            }
                        }
                    }
                }).catch(err => console.log(err));
            }
            return null;
        });
}
