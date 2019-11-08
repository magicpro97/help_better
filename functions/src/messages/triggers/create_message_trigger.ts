import * as functions from "firebase-functions";
import { DocumentSnapshot } from "@google-cloud/firestore";

export default function onMessageCreate() {
  return functions.firestore
    .document("message_groups/{messageGroupId}/{messages}/{messageId}")
    .onCreate((snapshot, context) => {
      if (context.params.messages === "messages") {
        updateMessageStatus(snapshot);
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

const updateMessageStatus = (snapshot: FirebaseFirestore.DocumentSnapshot) => {
  if (snapshot.exists) {
    const message = snapshot.data();
    if (message !== undefined) {
      const status = message["status"] as string;
      if (status === "SEND") {
        return snapshot.ref
          .update({
            status: nextMessageStatus(status)
          })
          .catch(err => console.log(err));
      }
    }
  }
  return snapshot;
};

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
