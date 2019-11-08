import * as functions from "firebase-functions";
import { DocumentReference } from "@google-cloud/firestore";
import { FCollection, User, MessageGroup } from "../../constants";

export default function onUserStateChange() {
    const { USERS, MESSAGES, MESSAGE_GROUPS } = FCollection;
    return functions.firestore
        .document(`${USERS}/{userId}`)
        .onWrite((change, _) => {
            const user = change.after.data() as User;
            if (user !== undefined && user.online) {
                const app = (change.after.ref.parent.parent as DocumentReference)
                return app.collection(`${MESSAGE_GROUPS}`).where("memberIds", "array-contains", user.id).get().then((mGSnap) => {
                    for (const mGDoc of mGSnap.docs) {
                        const messageGroup = mGDoc.data() as MessageGroup;
                        const friendIds = messageGroup.memberIds.filter((id) => id !== user.id);
                        mGDoc.ref.collection(`${MESSAGES}`).where("status", "==", "SENT").where("userId", "in", friendIds).get().then((mSnap) => {
                            for (const mDoc of mSnap.docs) {
                                mDoc.ref.update({
                                    status: "RECEIVED",
                                }).then().catch(err => console.log(err))
                            }
                        }).catch(err => console.log(err));
                    }
                }).catch(err => console.log(err));
            }
            return null;
        });
}
