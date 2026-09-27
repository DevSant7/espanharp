import { IOptionsFine, ISelectUsersFine } from "@/types";

import { create } from "zustand";

interface OptionsFrame {
  current: IOptionsFine;
  set: (current: IOptionsFine) => void;
}

interface SelectUserFrame {
  current: ISelectUsersFine;
  set: (current: ISelectUsersFine) => void;
}

interface DescriptionFrame {
  current: string;
  set: (current: string) => void;
}

export const useDescription = create<DescriptionFrame>((set) => ({
  current: "",
  set: (current: string) => set({ current }),
}));

export const useSelectUsers = create<SelectUserFrame>((set) => ({
  current: {
    suspects: [],
    infractions: [],
  },
  set: (current: ISelectUsersFine) => set({ current }),
}));

export const useOptions = create<OptionsFrame>((set) => ({
  current: {
    suspect: [],
    infractions: [],
  },
  set: (current: IOptionsFine) => set({ current }),
}));
