import * as motion from "motion/react-client";
import { Separator } from "@views/components/ui/separator";
import InvoiceHistory from "@views/components/InvoiceHistory";
import { useUserData } from "../../../hooks/useUserData";
import { useSelectedAccount } from "../../../hooks/useSelectedAccount";
import { useExpenses } from "../../../hooks/useExpenses";
import { useJointAccounts } from "../../../hooks/useJointAccounts";
import { UserAvatar } from "@views/components/UserAvatar";
import { useEffect, useState } from "react";
import { formatCurrency } from "../../../utils/formatCurrency";
import { fetchNui } from "../../../app/utils/fetchNui";

export function Invoices() {
  const userData = useUserData();
  const [invoices, setInvoices] = useState<any[]>([]);
  const [pendingTotal, setPendingTotal] = useState<number>(0);
  const { expenses, refreshExpenses } = useExpenses();

  const loadInvoices = async () => {
    const list = await fetchNui<any[]>("getUserInvoices");
    setInvoices(list || []);
    const total = await fetchNui<number>("getPendingInvoicesTotal");
    setPendingTotal(total || 0);
  };

  useEffect(() => {
    loadInvoices();
    refreshExpenses();
  }, []);
  const { selectedAccount, isPersonalAccount, isJointAccount } = useSelectedAccount();
  const { jointAccounts } = useJointAccounts();
  const [invoiceValue, setInvoiceValue] = useState<string>("0");
  const [isPayingInvoice, setIsPayingInvoice] = useState<boolean>(false);

  // Determinar dados da conta atual
  const currentAccountData = (() => {
    if (isPersonalAccount) {
      return {
        name: userData?.name || "Usuário",
        balance: userData?.bank || 0,
        type: "Conta pessoal"
      };
    } else if (isJointAccount && selectedAccount) {
      const jointAccount = jointAccounts.find(acc => acc.id.toString() === selectedAccount.id);
      return {
        name: jointAccount?.account_name || "Conta conjunta",
        balance: jointAccount?.balance || 0,
        type: `Conta ${jointAccount?.account_type || 'conjunta'}`
      };
    }
    return {
      name: userData?.name || "Usuário",
      balance: userData?.bank || 0,
      type: "Conta pessoal"
    };
  })();

  const handleInvoiceValueChange = (value: string) => {
    const cleanValue = value.replace(/[^\d.,]/g, "");
    setInvoiceValue(cleanValue);
  };

  const handlePayInvoice = async () => {
    const numericAmount = parseFloat(invoiceValue.replace(",", "."));
    if (isNaN(numericAmount) || numericAmount <= 0) {
      return;
    }

    setIsPayingInvoice(true);

    try {
      // Aqui você implementaria a lógica de pagamento de fatura
      console.log(`Pagando fatura de R$ ${numericAmount}`);

      // Simular delay do pagamento
      await new Promise((resolve) => setTimeout(resolve, 2000));

      // Reset form após sucesso
      setInvoiceValue("0");
    } catch (error) {
      console.error("Erro no pagamento da fatura:", error);
    } finally {
      setIsPayingInvoice(false);
    }
  };

  const formatAmount = (value: string) => {
    if (!value || value === "0") return "R$ 0";

    const numericValue = parseFloat(value.replace(",", "."));
    if (isNaN(numericValue)) return "R$ 0";

    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "BRL",
    }).format(numericValue);
  };

  return (
    <>
      <motion.div
        initial={{ opacity: 0, scale: 0 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{
          duration: 0.4,
          scale: { type: "spring", visualDuration: 0.4, bounce: 0.2 },
        }}
        className="w-[74rem] flex flex-col"
      >
        <div className="w-full h-[6rem] flex items-center justify-between p-6">
          <div className="flex items-center justify-center gap-4">
            <svg
              width="1.5rem"
              height="1.5rem"
              viewBox="0 0 24 24"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <rect
                width="24"
                height="24"
                rx="3"
                fill="#df5454"
                fill-opacity="0.08"
              />
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M4 20V7.55556C4 5.87911 4 5.04178 4.49347 4.52089C4.98695 4 5.78021 4 7.36842 4H15.7895C16.4901 4 17.0341 4 17.4771 4.024C16.55 4.13252 15.6934 4.59816 15.0712 5.33177C14.4491 6.06537 14.1052 7.01541 14.1053 8V11.1111L14.0219 19.9707L11.5789 19.1111L9.05263 20L6.52632 19.1111L4 20ZM20 11.1111H15.7895V8C15.7895 7.41063 16.0113 6.8454 16.4061 6.42865C16.8009 6.0119 17.3364 5.77778 17.8947 5.77778C18.4531 5.77778 18.9886 6.0119 19.3834 6.42865C19.7782 6.8454 20 7.41063 20 8V11.1111ZM5.68421 7.55556C5.68421 7.31981 5.77293 7.09372 5.93086 6.92702C6.08878 6.76032 6.30298 6.66667 6.52632 6.66667H11.5789C11.8023 6.66667 12.0165 6.76032 12.1744 6.92702C12.3323 7.09372 12.4211 7.31981 12.4211 7.55556C12.4211 7.7913 12.3323 8.0174 12.1744 8.18409C12.0165 8.35079 11.8023 8.44444 11.5789 8.44444H6.52632C6.30298 8.44444 6.08878 8.35079 5.93086 8.18409C5.77293 8.0174 5.68421 7.7913 5.68421 7.55556ZM5.68421 11.1111C5.68421 10.8754 5.77293 10.6493 5.93086 10.4826C6.08878 10.3159 6.30298 10.2222 6.52632 10.2222H8.21053C8.43387 10.2222 8.64806 10.3159 8.80598 10.4826C8.96391 10.6493 9.05263 10.8754 9.05263 11.1111C9.05263 11.3469 8.96391 11.573 8.80598 11.7397C8.64806 11.9063 8.43387 12 8.21053 12H6.52632C6.30298 12 6.08878 11.9063 5.93086 11.7397C5.77293 11.573 5.68421 11.3469 5.68421 11.1111ZM5.68421 14.6667C5.68421 14.4309 5.77293 14.2048 5.93086 14.0381C6.08878 13.8714 6.30298 13.7778 6.52632 13.7778H9.89474C10.1181 13.7778 10.3323 13.8714 10.4902 14.0381C10.6481 14.2048 10.7368 14.4309 10.7368 14.6667C10.7368 14.9024 10.6481 15.1285 10.4902 15.2952C10.3323 15.4619 10.1181 15.5556 9.89474 15.5556H6.52632C6.30298 15.5556 6.08878 15.4619 5.93086 15.2952C5.77293 15.1285 5.68421 14.9024 5.68421 14.6667Z"
                fill="#df5454"
              />
            </svg>

            <div className="flex items-center justify-center gap-2">
              <h1 className="text-white text-base font-bold">Faturas</h1>
              <span className="text-white/45 text-xs font-normal">/ Banco</span>
            </div>
          </div>

          <div className="flex items-center gap-6">
            <div className="text-right">
              <div className="text-white text-sm">{currentAccountData.name}</div>
              <div className="flex items-center justify-end gap-[.38rem]">
                <span className="text-white/55 text-[.6875rem]">
                  {currentAccountData.type}
                </span>
              </div>
            </div>

            <UserAvatar size="md" />
          </div>
        </div>

        <Separator className="w-full h-[0.0625rem] bg-[#FFFFFF08]" />

        <div className="flex flex-col items-center justify-center gap-4 p-4">
          <div className="flex items-center justify-center gap-4 w-full">
            <div
              className="flex flex-col rounded-md p-6 flex-1 max-w-[35rem]"
              style={{
                background:
                  "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
              }}
            >
              <div className="w-full flex items-center justify-between mb-4">
                <div className="flex flex-col items-start">
                  <div className="flex items-center justify-center gap-2">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width=".75rem"
                      height=".625rem"
                      viewBox="0 0 12 10"
                      fill="none"
                    >
                      <path
                        d="M12 9.58334C12 9.69385 11.9579 9.79983 11.8828 9.87796C11.8078 9.9561 11.7061 10 11.6 10H0.4C0.293913 10 0.192172 9.9561 0.117157 9.87796C0.0421427 9.79983 0 9.69385 0 9.58334C0 9.47284 0.0421427 9.36686 0.117157 9.28872C0.192172 9.21059 0.293913 9.16669 0.4 9.16669H11.6C11.7061 9.16669 11.8078 9.21059 11.8828 9.28872C11.9579 9.36686 12 9.47284 12 9.58334ZM0.415 3.8637C0.391209 3.77632 0.395479 3.68324 0.42716 3.59863C0.458842 3.51401 0.516199 3.44249 0.5905 3.39496L5.7905 0.0617184C5.85351 0.0213643 5.92603 0 6 0C6.07397 0 6.14649 0.0213643 6.2095 0.0617184L11.4095 3.39496C11.4838 3.44244 11.5412 3.5139 11.573 3.59848C11.6047 3.68306 11.609 3.77613 11.5853 3.86352C11.5616 3.95091 11.5111 4.02783 11.4416 4.08258C11.372 4.13733 11.2872 4.16691 11.2 4.16682H10V7.50007H10.8C10.9061 7.50007 11.0078 7.54396 11.0828 7.6221C11.1579 7.70024 11.2 7.80622 11.2 7.91672C11.2 8.02723 11.1579 8.1332 11.0828 8.21134C11.0078 8.28948 10.9061 8.33338 10.8 8.33338H1.2C1.09391 8.33338 0.992172 8.28948 0.917157 8.21134C0.842143 8.1332 0.8 8.02723 0.8 7.91672C0.8 7.80622 0.842143 7.70024 0.917157 7.6221C0.992172 7.54396 1.09391 7.50007 1.2 7.50007H2V4.16682H0.8C0.712894 4.16685 0.62816 4.13726 0.55867 4.08255C0.489181 4.02784 0.438736 3.951 0.415 3.8637ZM6.8 7.08341C6.8 7.19391 6.84214 7.29989 6.91716 7.37803C6.99217 7.45617 7.09391 7.50007 7.2 7.50007C7.30609 7.50007 7.40783 7.45617 7.48284 7.37803C7.55786 7.29989 7.6 7.19391 7.6 7.08341V4.58348C7.6 4.47297 7.55786 4.36699 7.48284 4.28886C7.40783 4.21072 7.09391 4.16682 7.2 4.16682C7.09391 4.16682 6.99217 4.21072 6.91716 4.28886C6.84214 4.36699 6.8 4.47297 6.8 4.58348V7.08341ZM4.4 7.08341C4.4 7.19391 4.44214 7.29989 4.51716 7.37803C4.59217 7.45617 4.69391 7.50007 4.8 7.50007C4.90609 7.50007 5.00783 7.45617 5.08284 7.37803C5.15786 7.29989 5.2 7.19391 5.2 7.08341V4.58348C5.2 4.47297 5.15786 4.36699 5.08284 4.28886C5.00783 4.21072 4.90609 4.16682 4.8 4.16682C4.69391 4.16682 4.59217 4.21072 4.51716 4.28886C4.44214 4.36699 4.4 4.47297 4.4 4.58348V7.08341Z"
                        fill="white"
                        fill-opacity="0.25"
                      />
                    </svg>

                    <h1 className="text-white/40 text-sm font-normal">
                      Balanço da sua conta
                    </h1>
                  </div>

                  <div className="flex items-center justify-center gap-2">
                    <h1 className="text-white/50 text-[2rem] font-bold">$</h1>
                    <h1 className="text-white text-[2rem] font-semibold">
                      {formatCurrency(currentAccountData.balance)}
                    </h1>
                  </div>
                </div>
                <svg
                  width="3.5rem"
                  height="3.5rem"
                  viewBox="0 0 56 56"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <rect
                    width="56"
                    height="56"
                    rx="8"
                    fill="#5BB376"
                    fill-opacity="0.06"
                  />
                  <path
                    d="M40 37.1667C40 37.3877 39.9157 37.5997 39.7657 37.7559C39.6157 37.9122 39.4122 38 39.2 38H16.8C16.5878 38 16.3843 37.9122 16.2343 37.7559C16.0843 37.5997 16 37.3877 16 37.1667C16 36.9457 16.0843 36.7337 16.2343 36.5774C16.3843 36.4212 16.5878 36.3334 16.8 36.3334H39.2C39.4122 36.3334 39.6157 36.4212 39.7657 36.5774C39.9157 36.7337 40 36.9457 40 37.1667ZM16.83 25.7274C16.7824 25.5526 16.791 25.3665 16.8543 25.1973C16.9177 25.028 17.0324 24.885 17.181 24.7899L27.581 18.1234C27.707 18.0427 27.8521 18 28 18C28.1479 18 28.293 18.0427 28.419 18.1234L38.819 24.7899C38.9676 24.8849 39.0824 25.0278 39.1459 25.197C39.2094 25.3661 39.2181 25.5523 39.1706 25.727C39.1232 25.9018 39.0222 26.0557 38.8831 26.1652C38.744 26.2747 38.5744 26.3338 38.4 26.3336H36V33.0001H37.6C37.8122 33.0001 38.0157 33.0879 38.1657 33.2442C38.3157 33.4005 38.4 33.6124 38.4 33.8334C38.4 34.0545 38.3157 34.2664 38.1657 34.4227C38.0157 34.579 37.8122 34.6668 37.6 34.6668H18.4C18.1878 34.6668 17.9843 34.579 17.8343 34.4227C17.6843 34.2664 17.6 34.0545 17.6 33.8334C17.6 33.6124 17.6843 33.4005 17.8343 33.2442C17.9843 33.0879 18.1878 33.0001 18.4 33.0001H20V26.3336H17.6C17.4258 26.3337 17.2563 26.2745 17.1173 26.1651C16.9784 26.0557 16.8775 25.902 16.83 25.7274ZM29.6 32.1668C29.6 32.3878 29.6843 32.5998 29.8343 32.7561C29.9843 32.9123 30.1878 33.0001 30.4 33.0001C30.6122 33.0001 30.8157 32.9123 30.9657 32.7561C31.1157 32.5998 31.2 32.3878 31.2 32.1668V27.167C31.2 26.9459 31.1157 26.734 30.9657 26.5777C30.8157 26.4214 30.6122 26.3336 30.4 26.3336C30.1878 26.3336 29.9843 26.4214 29.8343 26.5777C29.6843 26.734 29.6 26.9459 29.6 27.167V32.1668ZM24.8 32.1668C24.8 32.3878 24.8843 32.5998 25.0343 32.7561C25.1843 32.9123 25.3878 33.0001 25.6 33.0001C25.8122 33.0001 26.0157 32.9123 26.1657 32.7561C26.3157 32.5998 26.4 32.3878 26.4 32.1668V27.167C26.4 26.9459 26.3157 26.734 26.1657 26.5777C26.0157 26.4214 25.8122 26.3336 25.6 26.3336C25.3878 26.3336 25.1843 26.4214 25.0343 26.5777C24.8843 26.734 24.8 26.9459 24.8 27.167V32.1668Z"
                    fill="#5BB376"
                  />
                </svg>
              </div>

              <Separator className="w-full h-[0.0625rem] bg-white/[.03]" />

              <div className="w-full text-white/60 text-sm font-normal mt-3">
                Cresceu{" "}
                <span className="text-[#5BB376] text-sm font-medium">
                  +14,96%
                </span>{" "}
                nas últimas 4 semanas.
              </div>
            </div>

            <div
              className="flex flex-col rounded-md p-6 flex-1 max-w-[35rem]"
              style={{
                background:
                  "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
              }}
            >
              <div className="w-full flex items-center justify-between mb-4">
                <div className="flex flex-col items-start">
                  <div className="flex items-center justify-center gap-2">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width=".8125rem"
                      height=".375rem"
                      viewBox="0 0 13 6"
                      fill="none"
                    >
                      <path
                        fillRule="evenodd"
                        clipRule="evenodd"
                        d="M2.62725 1.69377C2.74281 1.43778 2.76491 1.14937 2.68972 0.87876C2.61453 0.608151 2.44681 0.372488 2.21575 0.21281C1.9847 0.0531324 1.70496 -0.0204435 1.42525 0.0048956C1.14554 0.0302346 0.883571 0.152883 0.684974 0.351483C0.486377 0.550082 0.36373 0.81205 0.338392 1.09177C0.313053 1.37148 0.386627 1.65123 0.546303 1.88228C0.705979 2.11334 0.941639 2.28106 1.21225 2.35626C1.48285 2.43145 1.77126 2.40934 2.02724 2.29378L3.43966 3.70622C3.35719 3.88898 3.32183 4.0895 3.33681 4.28945C3.3518 4.48941 3.41664 4.68242 3.52543 4.85085C3.63421 5.01929 3.78347 5.15778 3.95956 5.25368C4.13565 5.34957 4.33296 5.39982 4.53347 5.39982C4.73398 5.39982 4.9313 5.34957 5.10739 5.25368C5.28348 5.15778 5.43274 5.01929 5.54152 4.85085C5.65031 4.68242 5.71515 4.48941 5.73013 4.28945C5.74512 4.0895 5.70976 3.88898 5.62729 3.70622L7.0397 2.29378C7.1949 2.36385 7.36323 2.40009 7.53351 2.40009C7.70379 2.40009 7.87212 2.36385 8.02732 2.29378L10.0397 4.30623C9.92418 4.56222 9.90208 4.85063 9.97727 5.12124C10.0525 5.39185 10.2202 5.62751 10.4512 5.78719C10.6823 5.94687 10.962 6.02044 11.2417 5.9951C11.5215 5.96977 11.7834 5.84712 11.982 5.64852C12.1806 5.44992 12.3033 5.18795 12.3286 4.90823C12.3539 4.62852 12.2804 4.34877 12.1207 4.11772C11.961 3.88666 11.7254 3.71894 11.4547 3.64374C11.1841 3.56855 10.8957 3.59066 10.6397 3.70622L8.62732 1.69377C8.70979 1.511 8.74515 1.31048 8.73017 1.11053C8.71519 0.910579 8.65034 0.717569 8.54156 0.549133C8.43277 0.380696 8.28352 0.242203 8.10743 0.146307C7.93133 0.0504104 7.73402 0.000167928 7.53351 0.000167928C7.333 0.000167928 7.13569 0.0504104 6.9596 0.146307C6.7835 0.242203 6.63425 0.380696 6.52546 0.549133C6.41668 0.717569 6.35183 0.910579 6.33685 1.11053C6.32187 1.31048 6.35723 1.511 6.4397 1.69377L5.02728 3.1062C4.87209 3.03613 4.70375 2.99989 4.53347 2.99989C4.36319 2.99989 4.19486 3.03613 4.03967 3.1062L2.62725 1.69377Z"
                        fill="white"
                        fillOpacity="0.25"
                      />
                    </svg>

                    <h1 className="text-white/40 text-sm font-normal">
                      Despesas
                    </h1>
                  </div>

                  <div className="flex items-center justify-center gap-2">
                    <h1 className="text-white text-[2rem] font-semibold">
                      $ {formatCurrency(expenses)}
                    </h1>
                  </div>
                </div>
                <svg
                  width="3.5rem"
                  height="3.5rem"
                  viewBox="0 0 56 56"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <rect
                    width="56"
                    height="56"
                    rx="8"
                    fill="#B35B5B"
                    fill-opacity="0.06"
                  />
                  <path
                    fill-rule="evenodd"
                    clip-rule="evenodd"
                    d="M20.5875 25.3875C20.8186 24.8756 20.8628 24.2987 20.7125 23.7575C20.5621 23.2163 20.2266 22.745 19.7645 22.4256C19.3024 22.1063 18.7429 21.9591 18.1835 22.0098C17.6241 22.0605 17.1001 22.3058 16.703 22.703C16.3058 23.1002 16.0605 23.6241 16.0098 24.1835C15.9591 24.743 16.1063 25.3025 16.4256 25.7646C16.745 26.2267 17.2163 26.5621 17.7575 26.7125C18.2987 26.8629 18.8755 26.8187 19.3875 26.5876L22.2123 29.4124C22.0474 29.778 21.9767 30.179 22.0066 30.5789C22.0366 30.9788 22.1663 31.3648 22.3839 31.7017C22.6014 32.0386 22.8999 32.3156 23.2521 32.5074C23.6043 32.6991 23.9989 32.7996 24.4 32.7996C24.801 32.7996 25.1956 32.6991 25.5478 32.5074C25.9 32.3156 26.1985 32.0386 26.4161 31.7017C26.6336 31.3648 26.7633 30.9788 26.7933 30.5789C26.8232 30.179 26.7525 29.778 26.5876 29.4124L29.4124 26.5876C29.7228 26.7277 30.0595 26.8002 30.4 26.8002C30.7406 26.8002 31.0773 26.7277 31.3876 26.5876L35.4125 30.6125C35.1814 31.1244 35.1372 31.7013 35.2875 32.2425C35.4379 32.7837 35.7734 33.255 36.2355 33.5744C36.6976 33.8937 37.2571 34.0409 37.8165 33.9902C38.3759 33.9395 38.8999 33.6942 39.297 33.297C39.6942 32.8998 39.9395 32.3759 39.9902 31.8165C40.0409 31.257 39.8937 30.6975 39.5744 30.2354C39.255 29.7733 38.7837 29.4379 38.2425 29.2875C37.7013 29.1371 37.1245 29.1813 36.6125 29.4124L32.5877 25.3875C32.7526 25.022 32.8233 24.621 32.7934 24.2211C32.7634 23.8212 32.6337 23.4351 32.4161 23.0983C32.1986 22.7614 31.9 22.4844 31.5479 22.2926C31.1957 22.1008 30.801 22.0003 30.4 22.0003C29.999 22.0003 29.6044 22.1008 29.2522 22.2926C28.9 22.4844 28.6015 22.7614 28.3839 23.0983C28.1664 23.4351 28.0367 23.8212 28.0067 24.2211C27.9767 24.621 28.0475 25.022 28.2124 25.3875L25.3876 28.2124C25.0772 28.0723 24.7405 27.9998 24.4 27.9998C24.0594 27.9998 23.7227 28.0723 23.4123 28.2124L20.5875 25.3875Z"
                    fill="#B35B5B"
                  />
                </svg>
              </div>

              <Separator className="w-full h-[0.0625rem] bg-white/[.03]" />

              <div className="w-full text-white/60 text-sm font-normal mt-3">
                Nas últimas 4 semanas.
              </div>
            </div>
          </div>

          <div className="flex items-start justify-center gap-4 w-full">
            <div
              className="flex flex-col rounded-md p-6 flex-1 max-w-[35rem]"
              style={{
                background:
                  "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
              }}
            >
              <div className="w-full flex items-center justify-between mb-4">
                <div className="flex flex-col items-start">
                  <div className="flex items-center justify-center gap-2">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width=".625rem"
                      height=".625rem"
                      viewBox="0 0 10 10"
                      fill="none"
                    >
                      <path
                        fill-rule="evenodd"
                        clip-rule="evenodd"
                        d="M0 10V2.22222C0 1.17444 -3.13709e-08 0.651111 0.308421 0.325556C0.616842 -3.31137e-08 1.11263 0 2.10526 0H7.36842C7.80632 0 8.14632 -2.79397e-08 8.42316 0.015C7.84373 0.0828273 7.30835 0.37385 6.91953 0.832354C6.5307 1.29086 6.31574 1.88463 6.31579 2.5V4.44444L6.26368 9.98167L4.73684 9.44444L3.15789 10L1.57895 9.44444L0 10ZM10 4.44444H7.36842V2.5C7.36842 2.13164 7.50705 1.77837 7.75381 1.51791C8.00057 1.25744 8.33524 1.11111 8.68421 1.11111C9.03318 1.11111 9.36786 1.25744 9.61461 1.51791C9.86137 1.77837 10 2.13164 10 2.5V4.44444ZM1.05263 2.22222C1.05263 2.07488 1.10808 1.93357 1.20679 1.82939C1.30549 1.7252 1.43936 1.66667 1.57895 1.66667H4.73684C4.87643 1.66667 5.0103 1.7252 5.109 1.82939C5.20771 1.93357 5.26316 2.07488 5.26316 2.22222C5.26316 2.36956 5.20771 2.51087 5.109 2.61506C5.0103 2.71925 4.87643 2.77778 4.73684 2.77778H1.57895C1.43936 2.77778 1.30549 2.71925 1.20679 2.61506C1.10808 2.51087 1.05263 2.36956 1.05263 2.22222ZM1.05263 4.44444C1.05263 4.2971 1.10808 4.15579 1.20679 4.05161C1.30549 3.94742 1.43936 3.88889 1.57895 3.88889H2.63158C2.77117 3.88889 2.90504 3.94742 3.00374 4.05161C3.10244 4.15579 3.15789 4.2971 3.15789 4.44444C3.15789 4.59179 3.10244 4.73309 3.00374 4.83728C2.90504 4.94147 2.77117 5 2.63158 5H1.57895C1.43936 5 1.30549 4.94147 1.20679 4.83728C1.10808 4.73309 1.05263 4.59179 1.05263 4.44444ZM1.05263 6.66667C1.05263 6.51932 1.10808 6.37802 1.20679 6.27383C1.30549 6.16964 1.43936 6.11111 1.57895 6.11111H3.68421C3.8238 6.11111 3.95767 6.16964 4.05637 6.27383C4.15508 6.37802 4.21053 6.51932 4.21053 6.66667C4.21053 6.81401 4.15508 6.95532 4.05637 7.0595C3.95767 7.16369 3.8238 7.22222 3.68421 7.22222H1.57895C1.43936 7.22222 1.30549 7.16369 1.20679 7.0595C1.10808 6.95532 1.05263 6.81401 1.05263 6.66667Z"
                        fill="white"
                        fill-opacity="0.25"
                      />
                    </svg>
                    <h1 className="text-white/40 text-sm font-normal">
                      Faturas
                    </h1>
                  </div>

                  <div className="flex items-center justify-center gap-2">
                    <h1 className="text-white text-[2rem] font-semibold">
                      $ {formatCurrency(pendingTotal)}
                    </h1>
                  </div>
                </div>
                <svg
                  width="3.5rem"
                  height="3.5rem"
                  viewBox="0 0 56 56"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <rect
                    width="56"
                    height="56"
                    rx="8"
                    fill="#B38A5B"
                    fill-opacity="0.06"
                  />
                  <path
                    fill-rule="evenodd"
                    clip-rule="evenodd"
                    d="M19 37V23C19 21.114 19 20.172 19.5552 19.586C20.1103 19 21.0027 19 22.7895 19H32.2632C33.0514 19 33.6634 19 34.1617 19.027C33.1187 19.1491 32.155 19.6729 31.4551 20.4982C30.7553 21.3235 30.3683 22.3923 30.3684 23.5V27L30.2746 36.967L27.5263 36L24.6842 37L21.8421 36L19 37ZM37 27H32.2632V23.5C32.2632 22.837 32.5127 22.2011 32.9569 21.7322C33.401 21.2634 34.0034 21 34.6316 21C35.2597 21 35.8621 21.2634 36.3063 21.7322C36.7505 22.2011 37 22.837 37 23.5V27ZM20.8947 23C20.8947 22.7348 20.9945 22.4804 21.1722 22.2929C21.3499 22.1054 21.5908 22 21.8421 22H27.5263C27.7776 22 28.0185 22.1054 28.1962 22.2929C28.3739 22.4804 28.4737 22.7348 28.4737 23C28.4737 23.2652 28.3739 23.5196 28.1962 23.7071C28.0185 23.8946 27.7776 24 27.5263 24H21.8421C21.5908 24 21.3499 23.8946 21.1722 23.7071C20.9945 23.5196 20.8947 23.2652 20.8947 23ZM20.8947 27C20.8947 26.7348 20.9945 26.4804 21.1722 26.2929C21.3499 26.1054 21.5908 26 21.8421 26H23.7368C23.9881 26 24.2291 26.1054 24.4067 26.2929C24.5844 26.4804 24.6842 26.7348 24.6842 27C24.6842 27.2652 24.5844 27.5196 24.4067 27.7071C24.2291 27.8946 23.9881 28 23.7368 28H21.8421C21.5908 28 21.3499 27.8946 21.1722 27.7071C20.9945 27.5196 20.8947 27.2652 20.8947 27ZM20.8947 31C20.8947 30.7348 20.9945 30.4804 21.1722 30.2929C21.3499 30.1054 21.5908 30 21.8421 30H25.6316C25.8828 30 26.1238 30.1054 26.3015 30.2929C26.4791 30.4804 26.5789 30.7348 26.5789 31C26.5789 31.2652 26.4791 31.5196 26.3015 31.7071C26.1238 31.8946 25.8828 32 25.6316 32H21.8421C21.5908 32 21.3499 31.8946 21.1722 31.7071C20.9945 31.5196 20.8947 31.2652 20.8947 31Z"
                    fill="#B38A5B"
                  />
                </svg>
              </div>

              <Separator className="w-full h-[0.0625rem] bg-white/[.03]" />

              <div className="w-full text-white/60 text-sm font-normal mt-3">
                Faturas vencidas aguardando quitação.
              </div>
            </div>

            {/* Pay Invoice Card */}
            <div
              className="flex flex-col rounded-md p-6 flex-1 max-w-[35rem]"
              style={{
                background:
                  "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
              }}
            >
              <div className="flex items-center gap-2 mb-4">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width=".625rem"
                  height=".625rem"
                  viewBox="0 0 10 10"
                  fill="none"
                >
                  <path
                    fill-rule="evenodd"
                    clip-rule="evenodd"
                    d="M0 10V2.22222C0 1.17444 -3.13709e-08 0.651111 0.308421 0.325556C0.616842 -3.31137e-08 1.11263 0 2.10526 0H7.36842C7.80632 0 8.14632 -2.79397e-08 8.42316 0.015C7.84373 0.0828273 7.30835 0.37385 6.91953 0.832354C6.5307 1.29086 6.31574 1.88463 6.31579 2.5V4.44444L6.26368 9.98167L4.73684 9.44444L3.15789 10L1.57895 9.44444L0 10ZM10 4.44444H7.36842V2.5C7.36842 2.13164 7.50705 1.77837 7.75381 1.51791C8.00057 1.25744 8.33524 1.11111 8.68421 1.11111C9.03318 1.11111 9.36786 1.25744 9.61461 1.51791C9.86137 1.77837 10 2.13164 10 2.5V4.44444ZM1.05263 2.22222C1.05263 2.07488 1.10808 1.93357 1.20679 1.82939C1.30549 1.7252 1.43936 1.66667 1.57895 1.66667H4.73684C4.87643 1.66667 5.0103 1.7252 5.109 1.82939C5.20771 1.93357 5.26316 2.07488 5.26316 2.22222C5.26316 2.36956 5.20771 2.51087 5.109 2.61506C5.0103 2.71925 4.87643 2.77778 4.73684 2.77778H1.57895C1.43936 2.77778 1.30549 2.71925 1.20679 2.61506C1.10808 2.51087 1.05263 2.36956 1.05263 2.22222ZM1.05263 4.44444C1.05263 4.2971 1.10808 4.15579 1.20679 4.05161C1.30549 3.94742 1.43936 3.88889 1.57895 3.88889H2.63158C2.77117 3.88889 2.90504 3.94742 3.00374 4.05161C3.10244 4.15579 3.15789 4.2971 3.15789 4.44444C3.15789 4.59179 3.10244 4.73309 3.00374 4.83728C2.90504 4.94147 2.77117 5 2.63158 5H1.57895C1.43936 5 1.30549 4.94147 1.20679 4.83728C1.10808 4.73309 1.05263 4.59179 1.05263 4.44444ZM1.05263 6.66667C1.05263 6.51932 1.10808 6.37802 1.20679 6.27383C1.30549 6.16964 1.43936 6.11111 1.57895 6.11111H3.68421C3.8238 6.11111 3.95767 6.16964 4.05637 6.27383C4.15508 6.37802 4.21053 6.51932 4.21053 6.66667C4.21053 6.81401 4.15508 6.95532 4.05637 7.0595C3.95767 7.16369 3.8238 7.22222 3.68421 7.22222H1.57895C1.43936 7.22222 1.30549 7.16369 1.20679 7.0595C1.10808 6.95532 1.05263 6.81401 1.05263 6.66667Z"
                    fill="white"
                    fill-opacity="0.25"
                  />
                </svg>
                <h3 className="text-white/40 text-sm font-normal">
                  Pagar faturas
                </h3>
              </div>

              <div className="w-full">
                <div className="flex items-end gap-4 w-full">
                  <div className="flex-1">
                    <label className="text-white/60 text-sm font-medium mb-2 block">
                      Valor
                    </label>
                    <input
                      type="text"
                      value={invoiceValue}
                      onChange={(e) => handleInvoiceValueChange(e.target.value)}
                      placeholder="R$ 0"
                      className="w-full bg-white/[0.05] border border-white/[0.1] rounded-md px-4 py-3 text-white text-center placeholder-white/40 focus:outline-none focus:border-[#E74C3C] transition-colors"
                    />
                  </div>

                  <button
                    onClick={handlePayInvoice}
                    disabled={
                      isPayingInvoice ||
                      !invoiceValue ||
                      invoiceValue === "0" ||
                      parseFloat(invoiceValue.replace(",", ".")) <= 0
                    }
                    className="h-[3rem] px-8 bg-[#E74C3C] hover:bg-[#C0392B] disabled:opacity-50 disabled:cursor-not-allowed rounded-md font-medium text-sm transition-all flex items-center justify-center gap-2 text-white"
                  >
                    {isPayingInvoice ? (
                      <>
                        <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
                        PROCESSANDO...
                      </>
                    ) : (
                      <>PAGAR</>
                    )}
                  </button>
                </div>
              </div>
            </div>
          </div>

          <div className="w-full flex items-center justify-center">
            <InvoiceHistory className="w-full" />
          </div>
        </div>
      </motion.div>
    </>
  );
}
