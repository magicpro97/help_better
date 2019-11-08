import { Timestamp } from "@google-cloud/firestore";

export enum FCollection {
  MESSAGES = "messages",
  MESSAGE_GROUPS = "message_groups",
  USERS = "users"
}

interface Base {
  id: string;
  created: Timestamp;
  updated: Timestamp;
}

export interface User extends Base {
  displayName: string;
  online: boolean;
}

export interface Message extends Base {
  userId: string;
  status: string;
}

export interface MessageGroup extends Base {
  memberIds: string[];
}
