import { create } from "zustand";

type Data = number;

interface NuiFrame {
  current: Data;
  set: (current: Data) => void;
}

export const useSelection = create<NuiFrame>((set: any) => ({
  current: -1,
  set: (current: Data) => set({ current }),
}));
