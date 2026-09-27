import { create } from "zustand";

type Data = string;

interface NuiFrame {
  current: Data;
  set: (current: Data) => void;
}

export const useFilter = create<NuiFrame>((set: any) => ({
  current: "Hat",
  set: (current: Data) => set({ current }),
}));
