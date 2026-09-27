import React from "react";
import * as motion from "motion/react-client";

interface ModalProps {
  open: boolean;
  onClose?: () => void;
  children: React.ReactNode;
}

export function Modal({ open, onClose, children }: ModalProps) {
  if (!open) return null;

  return (
    <div
      className="w-[88.375rem] h-[49.9375rem] fixed inset-0 z-50 flex items-center justify-center bg-black/60 top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 rounded-2xl"
      onClick={onClose}
      aria-modal="true"
      role="dialog"
      style={{
        background:
          "linear-gradient(108deg, rgba(21, 28, 37, 0.96) 0%, rgba(8, 8, 9, 0.96) 100%)",
      }}
    >
      <motion.div
        initial={{ opacity: 0, scale: 0 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{
          duration: 0.4,
          scale: { type: "spring", visualDuration: 0.4, bounce: 0.2 },
        }}
        className="min-w-[22rem] max-w-[32rem] w-full rounded-[0.375rem] border border-white/[.05] shadow-lg relative bg-[#191E24A6]"
        onClick={(e: { stopPropagation: () => any }) => e.stopPropagation()}
      >
        {children}
      </motion.div>
    </div>
  );
}
