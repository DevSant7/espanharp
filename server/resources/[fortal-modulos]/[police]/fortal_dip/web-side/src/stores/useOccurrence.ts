import { IOccurrence, IOptionsOccurrence, ISelectOccurrence } from "@/types";

import { create } from "zustand";

interface OccurrenceFrame {
  current: IOccurrence[];
  set: (occurrences: IOccurrence[]) => void;
}

interface OptionsFrame {
  current: IOptionsOccurrence;
  set: (current: IOptionsOccurrence) => void;
}

interface SelectUserFrame {
  current: ISelectOccurrence;
  set: (current: ISelectOccurrence) => void;
}

interface DescriptionFrame {
  current: string;
  set: (current: string) => void;
}

export const useDescription = create<DescriptionFrame>((set) => ({
  current: "",
  set: (current: string) => set({ current }),
}));

export const useSelectOccurrence = create<SelectUserFrame>((set) => ({
  current: {
    applicant: [],
    suspects: [],
  },
  set: (current: ISelectOccurrence) => set({ current }),
}));

export const useOptions = create<OptionsFrame>((set) => ({
  current: {
    applicant: [],
    suspects: [],
  },
  set: (current: IOptionsOccurrence) => set({ current }),
}));

export const useOccurrence = create<OccurrenceFrame>((set) => ({
  current: [],
  set: (occurrences: IOccurrence[]) => set({ current: occurrences }),
}));
