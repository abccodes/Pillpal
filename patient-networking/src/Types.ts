export interface Port {
    number: number;
    connected: boolean; // true if the port is reporting data to the server
    amperage: number; // will be 0 if not connected
}

export interface PDM {
    id: string;
    nickname: string;
    connected: boolean;
    ports: Port[];
}

export enum LogLevel {
    DEBUG = 0,
    INFO = 1,
    WARN = 2,
    ERROR = 3,
    FATAL = 4,
}