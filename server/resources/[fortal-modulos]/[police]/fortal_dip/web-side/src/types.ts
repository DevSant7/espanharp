export interface NuiVisibilityFrame {
  setVisible: (visible: boolean) => void;
  visible: boolean;
}

export interface NuiMessageDataFrame<T = any> {
  action: string;
  data: T;
}

export interface NuiDebugEventFrame {
  action: string;
  data: any;
}

export interface IAnnounce {
  id: string;
  title: string;
  description: string;
  createdAt: string;
}

export interface IPlayer {
  name: string;
  passport: string;
  photo?: string;
}

export interface ISelectedStatistics {
  date: string;
  data: unknown[];
}

interface IHistory {
  type: string;
  date: string;
  name: string;
  id: number;
  description: string;
  time: string | number;
}

export interface IPlayerSearch {
  name: string;
  passport: string;
  photo?: string;
  register: string;
  wanted: string;
  years: number;
  size: string;
  history: IHistory[];
}

export interface IOptions {
  suspect: {
    id: number;
    name: string;
  }[];
  infractions: {
    art: number;
    description: string;
  }[];
}

export interface IOptionsFine {
  suspect: {
    id: number;
    name: string;
  }[];
  infractions: {
    art: number;
    description: string;
  }[];
}

export interface IOptionsOccurrence {
  applicant: {
    id: number;
    name: string;
  }[];
  suspects: {
    id: number;
    name: string;
  }[];
}

export interface ISelectUsers {
  suspects: { id: number; name: string }[];
  infractions: { id: number; art: string; description: string }[];
  prisonType?: 'normal' | 'maxima';
  [key: string]: { id: number }[] | string | undefined;
}

export interface ISelectOccurrence {
  applicant: { id: number; name: string }[];
  suspects: { id: number; name: string }[];
  [key: string]: { id: number; name?: string }[];
}

export interface ISelectUsersFine {
  suspects: { id: number; name: string }[];
  infractions: { id: number; art: string; description: string }[];
  [key: string]: { id: number }[];
}

export interface IWantedUser {
  photo?: string;
  name: string;
  date: string;
  description: string;
  lastSeen: string;
  location: string;
}

export interface IWantedVehicle {
  model: string;
  specifications: string;
  lastSeen: string;
  location: string;
  date: string;
}

export interface IOccurrence {
  id: number;
  date: string;
  officerName: string;
  description: string;
  status: string;
  occurrenceNumber: string;
  type: string;
  applicantName: string;
  suspectName: string;
}

export interface IMembers {
  id: number;
  name: string;
  charge: string;
  rank: number;
  rankName: string;
  rankLabel: string;
  date: string;
  status: boolean;
}

export interface ITime {
  month: string;
  fine: number;
}

export interface selectedStatisticsProps {
  date: string;
  data: unknown[];
}
