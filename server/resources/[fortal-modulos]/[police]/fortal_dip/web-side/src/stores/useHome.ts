import { IAnnounce } from "@/types";
import { create } from "zustand";

interface AnnounceFrame {
  current: IAnnounce[];
  set: (current: IAnnounce[]) => void;
}

export const useAnnounceFrame = create<AnnounceFrame>((set) => ({
  current: [],
  set: (current: IAnnounce[]) => set({ current }),
}))