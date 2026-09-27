import { create } from "zustand";

type Data = number;

interface NuiFrame {
  current: Data;
  set: (current: Data) => void;
}

export const usePrice = create<NuiFrame>((set) => ({
  current: 0,
  set: (current: Data) => set({ current }),
}));
