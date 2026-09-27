import { create } from "zustand";

type Data = boolean;

interface NuiFrame {
  current: Data;
  set: (current: Data) => void;
}

export const useSave = create<NuiFrame>((set: any) => ({
  current: false,
  set: (current: Data) => set({ current }),
}));
