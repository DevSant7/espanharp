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

export interface Action {
  distance: number;
  laps: number;
  MaxLaps: number;
}

export type Data = true | Action;
