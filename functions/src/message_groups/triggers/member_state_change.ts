import * as functions from "firebase-functions";
import { MessageGroup, Message, MemberState, MessageStatus } from "../../constants";
import { Timestamp } from "@google-cloud/firestore";

export default function onMemberStateChange() {
    return functions.firestore.document("message_groups/{messageGroupId}").onWrite((change, context) => {
        const messageGroup = change.after.data() as MessageGroup;
        const memberIds = messageGroup.memberIds;
        const memberStatus = messageGroup.memberStatus;
        return change.after.ref.collection("messages").where("userId", "in", memberIds).orderBy("updated", "desc").get().then(
            (mSnap) => {
                for (const memberId of memberIds) {
                    const mStatus = memberStatus[memberId];
                    if (mStatus === MemberState.IN) {
                        for (const mDoc of mSnap.docs) {
                            const message = mDoc.data() as Message;
                            const messageStatus = message.status[memberId];
                            if (message.userId !== memberId && messageStatus !== MessageStatus.SEEN) {
                                message.status[memberId] = MessageStatus.SEEN;
                                mDoc.ref.update({
                                    status: message.status,
                                    updated: Timestamp.now(),
                                }).catch(err => console.log(err));
                            }
                        }
                    }
                }
            }
        ).catch(err => console.log(err));
    });
}