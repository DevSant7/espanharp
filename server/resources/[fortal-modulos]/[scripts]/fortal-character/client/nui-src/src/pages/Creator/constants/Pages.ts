import Appearance from "../pages/Appearance";
import Characteristics from "../pages/Characteristics";
import Genetics from "../pages/Genetics";
import Hair from "../pages/Hair";
import { Icons } from "../components/Icons";

export const Pages: Record<
  string,
  {
    component: () => JSX.Element;
    icon: () => JSX.Element;
  }
> = {
  "1": {
    icon: Icons.Navigation.Genetics,
    component: Genetics,
  },
  "2": {
    icon: Icons.Navigation.Characteristics,
    component: Characteristics,
  },
  "3": {
    icon: Icons.Navigation.Appearance,
    component: Appearance,
  },
  "4": {
    icon: Icons.Navigation.Hair,
    component: Hair,
  },
};
