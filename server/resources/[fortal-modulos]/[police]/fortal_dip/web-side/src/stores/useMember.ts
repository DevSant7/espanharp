import { IMembers } from "@/types";
import { create } from "zustand";

interface MemberFrame {
  current: IMembers[];
  set: (members: IMembers[]) => void;
}

export const useMember = create<MemberFrame>((set) => ({
  current: [],
  set: (members) => set({ current: members }),
}));
