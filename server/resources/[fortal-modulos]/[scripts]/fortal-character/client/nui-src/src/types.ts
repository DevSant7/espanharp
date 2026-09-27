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

export interface Notify {
  title: string;
  description: string;
  delay: number;
}

export interface NotifyList extends Notify {
  id: number;
  isExiting: boolean;
  visible: boolean;
}