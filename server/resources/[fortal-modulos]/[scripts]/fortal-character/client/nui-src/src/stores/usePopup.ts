import { create } from "zustand";

export type Popup = {
  title: string;
  description: string;
  callback: () => void
} | false;

interface NuiFrame {
  current: Popup;
  set: (current: Popup) => void;
}

export const usePopup = create<NuiFrame>((set: any) => ({
  current: false,
  set: (current: Popup) => set({ current }),
}));
