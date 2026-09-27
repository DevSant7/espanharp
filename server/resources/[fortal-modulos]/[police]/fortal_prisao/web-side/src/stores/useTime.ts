import { ITime } from "@/types";
import { create } from "zustand";

interface TimeFrame {
  current: ITime;
  set: (current: ITime) => void;
}

export const useTime = create<TimeFrame>((set) => ({
  current: {
    month: 0,
    fine: 0,
  },
  set: (current: ITime) => set({ current }),
}));
