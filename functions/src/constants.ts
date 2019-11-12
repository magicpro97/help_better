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
    tokens: string[];
    photoUrl: string;
}

export interface Message extends Base {
    userId: string;
    status: Record<string, string>;
    content: string;
}

export enum MessageStatus {
    SEND = "SEND",
    SENT = "SENT",
    RECEIVED = "RECEIVED",
    SEEN = "SEEN"
}

export enum MemberState {
    IN = "IN",
    OUT = "OUT"
}

export interface MessageGroup extends Base {
    memberIds: string[];
    memberStatus: Record<string, string>;
}
