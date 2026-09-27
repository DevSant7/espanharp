import { create } from "zustand";

type Data = string;

interface NuiFrame {
  current: Data;
  set: (current: Data) => void;
}

export const useCamera = create<NuiFrame>((set: any) => ({
  current: "fullbody",
  set: (current: Data) => set({ current }),
}));
