import { BrowserRouter } from "react-router-dom";
import * as motion from "motion/react-client";
import { Router } from "@app/Router";
import { isEnvBrowser } from "@app/utils/misc";
import clsx from "clsx";
import Sidebar from "@views/components/sidebar";
import { Separator } from "@views/components/ui/separator";

export function App() {
  return (
    <BrowserRouter>
      <div
        className={clsx(
          "w-screen h-screen antialiased flex items-center justify-center",
          isEnvBrowser() && "bg-zinc-700"
        )}
      >
        <motion.div
          initial={{ opacity: 0, scale: 0 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{
            duration: 0.4,
            scale: { type: "spring", visualDuration: 0.4, bounce: 0.5 },
          }}
          className="w-[88.375rem] h-[49.9375rem] border border-[#22222B] rounded-[1rem] flex items-start justify-start"
          style={{
            background:
              "linear-gradient(108deg, rgba(21, 28, 37, 0.96) 0%, rgba(8, 8, 9, 0.96) 100%)",
          }}
        >
          <Sidebar />
          <Separator className="h-full bg-[#FFFFFF08]" orientation="vertical" />
          <Router />
        </motion.div>
      </div>
    </BrowserRouter>
  );
}
