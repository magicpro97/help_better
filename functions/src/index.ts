import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();

const db = admin.firestore();

export const createMessageTrigger = functions.firestore
  .document("message_groups/{messageGroupId}/{messages}/{messageId}")
  .onWrite((change, context) => {
    if (context.params.messages === "messages") {
      updateMessageStatus(change);
      // update message groups
      const createTime = change.after.createTime;
      if (change.after.ref.parent.parent !== null) {
        const doc = change.after.ref.parent.parent;
        return db
          .collection("message_groups")
          .doc(doc.id)
          .update({
            updated: createTime
          })
          .catch(err => console.log(err));
      }
    }
    return null;
  });

function updateMessageStatus(
  change: functions.Change<FirebaseFirestore.DocumentSnapshot>
) {
  const message = change.after.data();
  if (message !== undefined) {
    const status = message["status"] as string;
    if (status === "SEND") {
      change.after.ref
        .update({
          status: nextMessageStatus(status)
        })
        .catch(err => console.log(err));
    }
  }
}

function nextMessageStatus(status: string): string {
  switch (status) {
    case "SEND":
      return "SENT";
    case "SENT":
      return "RECEIVED";
    case "RECEIVED":
      return "READ";
  }
  return "";
}
