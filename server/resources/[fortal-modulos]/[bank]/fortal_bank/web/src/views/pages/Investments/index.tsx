import * as motion from "motion/react-client";
import { Separator } from "@views/components/ui/separator";
import InvestmentChart from "../../components/InvestmentChart";
import { useUserData } from "../../../hooks/useUserData";
import { useSelectedAccount } from "../../../hooks/useSelectedAccount";
import { useJointAccounts } from "../../../hooks/useJointAccounts";
import { UserAvatar } from "@views/components/UserAvatar";
import { formatCurrency } from "../../../utils/formatCurrency";
import { useState } from "react";

export function Investments() {
  const userData = useUserData();
  const { selectedAccount, isPersonalAccount, isJointAccount } = useSelectedAccount();
  const { jointAccounts } = useJointAccounts();
  const [investmentValue, setInvestmentValue] = useState<string>("0");
  const [isInvesting, setIsInvesting] = useState<boolean>(false);
  const [isWithdrawing, setIsWithdrawing] = useState<boolean>(false);

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

  const handleInvestmentValueChange = (value: string) => {
    const cleanValue = value.replace(/[^\d.,]/g, "");
    setInvestmentValue(cleanValue);
  };

  const handleInvest = async () => {
    const numericAmount = parseFloat(investmentValue.replace(",", "."));
    if (isNaN(numericAmount) || numericAmount <= 0) {
      return;
    }

    setIsInvesting(true);

    try {
      // Aqui você implementaria a lógica de investimento
      console.log(`Investindo R$ ${numericAmount}`);

      // Simular delay do investimento
      await new Promise((resolve) => setTimeout(resolve, 2000));

      // Reset form após sucesso
      setInvestmentValue("0");
    } catch (error) {
      console.error("Erro no investimento:", error);
    } finally {
      setIsInvesting(false);
    }
  };

  const handleWithdraw = async () => {
    const numericAmount = parseFloat(investmentValue.replace(",", "."));
    if (isNaN(numericAmount) || numericAmount <= 0) {
      return;
    }

    setIsWithdrawing(true);

    try {
      // Aqui você implementaria a lógica de saque
      console.log(`Sacando R$ ${numericAmount} do investimento`);

      // Simular delay do saque
      await new Promise((resolve) => setTimeout(resolve, 2000));

      // Reset form após sucesso
      setInvestmentValue("0");
    } catch (error) {
      console.error("Erro no saque:", error);
    } finally {
      setIsWithdrawing(false);
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
                d="M19 6.75C19 6.33579 18.6701 6 18.2632 6H16.0526C15.6457 6 15.3158 6.33579 15.3158 6.75V17.25C15.3158 17.6642 15.6457 18 16.0526 18H18.2632C18.6701 18 19 17.6642 19 17.25V6.75Z"
                fill="#df5454"
              />
              <path
                d="M13.8421 10.5C13.8421 10.0858 13.5122 9.75 13.1053 9.75H10.8947C10.4878 9.75 10.1579 10.0858 10.1579 10.5V17.25C10.1579 17.6642 10.4878 18 10.8947 18H13.1053C13.5122 18 13.8421 17.6642 13.8421 17.25V10.5Z"
                fill="#df5454"
              />
              <path
                d="M8.68421 15C8.68421 14.5858 8.35432 14.25 7.94737 14.25H5.73684C5.3299 14.25 5 14.5858 5 15V17.25C5 17.6642 5.3299 18 5.73684 18H7.94737C8.35432 18 8.68421 17.6642 8.68421 17.25V15Z"
                fill="#df5454"
              />
            </svg>

            <div className="flex items-center justify-center gap-2">
              <h1 className="text-white text-base font-bold">Investimentos</h1>
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
                        fillOpacity="0.25"
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
                    <h1 className="text-white/50 text-[2rem] font-bold">$</h1>
                    <h1 className="text-white text-[2rem] font-semibold">
                      23,943
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
              className="flex flex-col rounded-md p-6 flex-1 max-w-[35rem] border border-[#df5454]"
              style={{
                background:
                  "radial-gradient(272.33% 149.42% at -6.74% 127.5%, rgba(60, 142, 220, 0.05) 0%, rgba(60, 142, 220, 0.00) 100%), radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
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
                        d="M12 0.625C12 0.279822 11.7172 0 11.3684 0H9.47368C9.12487 0 8.8421 0.279822 8.8421 0.625V9.375C8.8421 9.72018 9.12487 10 9.47368 10H11.3684C11.7172 10 12 9.72018 12 9.375V0.625Z"
                        fill="#df5454"
                      />
                      <path
                        d="M7.57895 3.75C7.57895 3.40482 7.29618 3.125 6.94737 3.125H5.05263C4.70382 3.125 4.42105 3.40482 4.42105 3.75V9.375C4.42105 9.72018 4.70382 10 5.05263 10H6.94737C7.29618 10 7.57895 9.72018 7.57895 9.375V3.75Z"
                        fill="#df5454"
                      />
                      <path
                        d="M3.15789 7.5C3.15789 7.15482 2.87513 6.875 2.52632 6.875H0.631579C0.282768 6.875 0 7.15482 0 7.5V9.375C0 9.72018 0.282768 10 0.631579 10H2.52632C2.87513 10 3.15789 9.72018 3.15789 9.375V7.5Z"
                        fill="#df5454"
                      />
                    </svg>
                    <h1 className="text-white text-sm font-normal">
                      CDB 115% 🔥
                    </h1>
                  </div>

                  <div className="flex items-center justify-center gap-2">
                    <h1 className="text-white/50 text-[2rem] font-bold">$</h1>
                    <h1 className="text-white text-[2rem] font-semibold">
                      1,945,694
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
                    fill="#df5454"
                    fill-opacity="0.06"
                  />
                  <path
                    d="M39 20.125C39 19.5037 38.4816 19 37.8421 19H34.3684C33.7289 19 33.2105 19.5037 33.2105 20.125V35.875C33.2105 36.4963 33.7289 37 34.3684 37H37.8421C38.4816 37 39 36.4963 39 35.875V20.125Z"
                    fill="#df5454"
                  />
                  <path
                    d="M30.8947 25.75C30.8947 25.1287 30.3763 24.625 29.7368 24.625H26.2632C25.6237 24.625 25.1053 25.1287 25.1053 25.75V35.875C25.1053 36.4963 25.6237 37 26.2632 37H29.7368C30.3763 37 30.8947 36.4963 30.8947 35.875V25.75Z"
                    fill="#df5454"
                  />
                  <path
                    d="M22.7895 32.5C22.7895 31.8787 22.2711 31.375 21.6316 31.375H18.1579C17.5184 31.375 17 31.8787 17 32.5V35.875C17 36.4963 17.5184 37 18.1579 37H21.6316C22.2711 37 22.7895 36.4963 22.7895 35.875V32.5Z"
                    fill="#df5454"
                  />
                </svg>
              </div>

              <Separator className="w-full h-[0.0625rem] bg-white/[.03]" />

              <div className="w-full text-white/60 text-sm font-normal mt-3">
                Lucrou{" "}
                <span className="text-[#5BB376] text-sm font-medium">
                  $49,583
                </span>{" "}
                nas últimas 24 horas.
              </div>
            </div>

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
                  width=".75rem"
                  height=".625rem"
                  viewBox="0 0 12 10"
                  fill="none"
                >
                  <path
                    d="M12 0.625C12 0.279822 11.7172 0 11.3684 0H9.47368C9.12487 0 8.8421 0.279822 8.8421 0.625V9.375C8.8421 9.72018 9.12487 10 9.47368 10H11.3684C11.7172 10 12 9.72018 12 9.375V0.625Z"
                    fill="white"
                    fill-opacity="0.25"
                  />
                  <path
                    d="M7.57895 3.75C7.57895 3.40482 7.29618 3.125 6.94737 3.125H5.05263C4.70382 3.125 4.42105 3.40482 4.42105 3.75V9.375C4.42105 9.72018 4.70382 10 5.05263 10H6.94737C7.29618 10 7.57895 9.72018 7.57895 9.375V3.75Z"
                    fill="white"
                    fill-opacity="0.25"
                  />
                  <path
                    d="M3.15789 7.5C3.15789 7.15482 2.87513 6.875 2.52632 6.875H0.631579C0.282768 6.875 0 7.15482 0 7.5V9.375C0 9.72018 0.282768 10 0.631579 10H2.52632C2.87513 10 3.15789 9.72018 3.15789 9.375V7.5Z"
                    fill="white"
                    fill-opacity="0.25"
                  />
                </svg>
                <h3 className="text-white/40 text-sm font-normal">Investir</h3>
              </div>

              <div className="space-y-4 w-full">
                <div className="flex items-end gap-2 w-full">
                  <div className="flex-1">
                    <label className="text-white/60 text-sm font-medium mb-2 block">
                      Valor
                    </label>
                    <input
                      type="text"
                      value={investmentValue}
                      onChange={(e) =>
                        handleInvestmentValueChange(e.target.value)
                      }
                      placeholder="R$ 0"
                      className="w-full bg-white/[0.05] border border-white/[0.1] rounded-md px-4 py-3 text-white text-center placeholder-white/40 focus:outline-none focus:border-[#5BB376] transition-colors"
                    />
                  </div>

                  <div className="flex gap-2">
                    <button
                      onClick={handleInvest}
                      disabled={
                        isInvesting ||
                        isWithdrawing ||
                        !investmentValue ||
                        investmentValue === "0" ||
                        parseFloat(investmentValue.replace(",", ".")) <= 0
                      }
                      className="h-[3rem] px-4 bg-[#5BB376] hover:bg-[#4A9B63] disabled:opacity-50 disabled:cursor-not-allowed rounded-md font-medium text-sm transition-all flex items-center justify-center gap-2 text-white"
                    >
                      {isInvesting ? (
                        <>
                          <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
                        </>
                      ) : (
                        <>INVESTIR</>
                      )}
                    </button>

                    <button
                      onClick={handleWithdraw}
                      disabled={
                        isInvesting ||
                        isWithdrawing ||
                        !investmentValue ||
                        investmentValue === "0" ||
                        parseFloat(investmentValue.replace(",", ".")) <= 0
                      }
                      className="h-[3rem] px-4 bg-[#E74C3C] hover:bg-[#C0392B] disabled:opacity-50 disabled:cursor-not-allowed rounded-md font-medium text-sm transition-all flex items-center justify-center gap-2 text-white"
                    >
                      {isWithdrawing ? (
                        <>
                          <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
                        </>
                      ) : (
                        <>SACAR</>
                      )}
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div className="w-full flex items-center justify-center">
            <InvestmentChart className="w-full" />
          </div>
        </div>
      </motion.div>
    </>
  );
}
