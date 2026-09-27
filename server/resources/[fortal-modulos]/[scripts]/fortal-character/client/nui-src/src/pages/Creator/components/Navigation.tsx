import { useLocation, useNavigate } from "react-router-dom";

import { Icons } from "./Icons";
import { Pages } from "../constants/Pages";
import { cn } from "@/utils/misc";
import { createElement } from "react";

export default function Navigation() {
  const location = useLocation();
  const navigate = useNavigate();

  return (
    <nav className="flex flex-col items-center">
      <Icons.Navigation.Bar />
      <div className="flex flex-col gap-1.5">
        {Object.keys(Pages).map((id: string) => {
          const data = Pages[id];
          const active = (): boolean => {
            if (id == "1") {
              return location.pathname === "/creator";
            } else {
              return location.pathname.endsWith(id);
            }
          };
          const select = () => {
            if (id == "1") {
              navigate(`/creator`);
            } else {
              navigate(`/creator/${id}`);
            }
          };
          return (
            <button
              key={id}
              onClick={select}
              className="group relative grid w-[3.9375rem] place-items-center active:scale-95 transition-all duration-200"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                className="w-full"
                viewBox="0 0 55 63"
                fill="none"
              >
                <path
                  d="M8.49848 45.0206C6.95233 44.1272 6 42.477 6 40.6913L6 22.3087C6 20.523 6.95233 18.8728 8.49848 17.9794L24.9985 8.44542C26.5463 7.55109 28.4537 7.55109 30.0015 8.44543L46.5015 17.9794C48.0477 18.8728 49 20.523 49 22.3087V40.6913C49 42.477 48.0477 44.1272 46.5015 45.0206L30.0015 54.5546C28.4537 55.4489 26.5463 55.4489 24.9985 54.5546L8.49848 45.0206Z"
                  className={cn(
                    active()
                      ? "fill-primary/50"
                      : "fill-white/3 group-hover:fill-primary/25 transition-all duration-200",
                  )}
                />
                <path
                  d="M6.5 40.6914L6.5 22.3086C6.50003 20.802 7.25347 19.4028 8.49414 18.5713L8.74902 18.4121L25.249 8.87793C26.6418 8.07339 28.3582 8.07339 29.751 8.87793L46.251 18.4121C47.6425 19.2161 48.5 20.7015 48.5 22.3086V40.6914C48.5 42.2985 47.6425 43.7839 46.251 44.5879L29.751 54.1221C28.3582 54.9266 26.6418 54.9266 25.249 54.1221L8.74902 44.5879C7.35751 43.7839 6.50003 42.2985 6.5 40.6914Z"
                  className={cn(
                    active()
                      ? "stroke-primary"
                      : "stroke-white/10 group-hover:stroke-primary/50 transition-all duration-200",
                  )}
                />
                <path
                  d="M5.10403 50.4247C1.95153 48.6546 0 45.3207 0 41.7052L0 21.0938C0 17.4538 1.97789 14.1013 5.16393 12.341L22.6639 2.67199C25.6736 1.00913 29.3264 1.00913 32.3361 2.67199L49.8361 12.341C53.0221 14.1013 55 17.4538 55 21.0938V41.7052C55 45.3207 53.0485 48.6546 49.896 50.4247L32.396 60.2509C29.3553 61.9583 25.6447 61.9583 22.604 60.2509L5.10403 50.4247Z"
                  className={cn(
                    active()
                      ? "fill-primary/2"
                      : "fill-white/1 group-hover:fill-primary/2 transition-all duration-200",
                  )} 
                />
                <path
                  d="M1 41.7051L1 21.0938C1.00003 17.9202 2.6706 14.9896 5.38184 13.3691L5.64746 13.2158L23.1475 3.54688C25.8561 2.05038 29.1439 2.05038 31.8525 3.54688L49.3525 13.2158C52.22 14.8001 54 17.8178 54 21.0938V41.7051C54 44.959 52.2435 47.9596 49.4062 49.5527L31.9062 59.3789C29.1696 60.9155 25.8304 60.9155 23.0938 59.3789L5.59375 49.5527C2.84524 48.0095 1.11067 45.1455 1.00488 42.0098L1 41.7051Z"
                  className={cn(
                    active()
                      ? "stroke-primary"
                      : "stroke-white/15 group-hover:stroke-primary/50 transition-all duration-200",
                  )}
                  strokeWidth="2"
                />
              </svg>
              <div
                className={cn(
                  "absolute",
                  !active() && "opacity-65 group-hover:opacity-100 transition-all duration-200",
                )}
              >
                {createElement(data.icon)}
              </div>
            </button>
          );
        })}
      </div>
    </nav>
  );
}
