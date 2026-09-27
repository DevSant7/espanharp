import { useState } from "react";
import type { Notify, NotifyList } from "@/types";
import { cn } from "@/utils/misc";
import { observe } from "@/hooks/observe";

export default function Notifys() {
  const [notifys, setNotifys] = useState<NotifyList[]>([]);
  
  observe<Notify>("addNotify", (data) => {
    const thisIndex = Math.floor(Math.random() * 10001);

    setNotifys((prev) => [...prev, { ...data, id: thisIndex, isExiting: false, visible: false }]);
    setTimeout(() => {
        setNotifys((prev) =>
            prev.map((e) =>
                e.id === thisIndex ? { ...e, visible: true } : e
            )
        );
    }, 100);   

    setTimeout(() => {
        setNotifys((prev) =>
            prev.map((e) =>
                e.id === thisIndex ? { ...e, isExiting: true } : e
            )
        );
        setTimeout(() => {
            setNotifys((prev) => prev.filter((e: NotifyList) => e.id !== thisIndex))
        }, 500);
    }, data.delay || 8000);
  });

  return (
    <div className="absolute flex flex-col items-start right-[2rem] top-[9rem] gap-[2.315vh] overflow-visible">
      {notifys.map((response: NotifyList) => (
        <div
          key={response.id}
          className={cn(
              "transition-all duration-300 transform",
              response.isExiting
              ? "opacity-0 translate-x-0"
              : response.visible
              ? "opacity-100 -translate-x-4"
              : "opacity-0 translate-x-0",
              "flex gap-[1.389vh] overflow-visible",
              "bg-section border-solid border-[.1vw] border-white/10",
              "rounded-[0.463vh] px-4 py-2 min-w-[15rem]"
          )}
        >
          <div className="flex items-center gap-[1vw]">
            <div>
              <header className="flex flex-row items-center gap-[0.4vw]">
                <div className="size-[0.3vw] bg-primary rounded-full"></div>
                <h1 className="text-white text-[.8vw] font-bold">
                  {response.title}
                </h1>
              </header>
              <p className="text-white leading-2 text-sm font-medium" dangerouslySetInnerHTML={{ __html: response.description }}></p>
            </div>
          </div>
        </div>
      ))}
    </div>
  )
}