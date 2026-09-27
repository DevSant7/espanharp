import { Route, Routes, useLocation, Navigate } from "react-router-dom";

import { AddMember, FireMemberModal } from "@/components/_components/Modals/AddMember";
import { AnnounceModal } from "@/components/_components/Modals/AnnounceModal";
import { Fine } from "@/pages/Fine";
import { FineModal } from "@/components/_components/Modals/FineModal";
import { Home } from "@/pages/Home";
import { Locked } from "@/pages/Locked";
import { Members } from "@/pages/Members";
import { Navigation } from "@/components/_components/Navigation";
import { Occurrence } from "@/pages/Occurrence";
import { OccurrenceModal } from "@/components/_components/Modals/OccurrenceModal";
import { PrisonModal } from "@/components/_components/Modals/PrisionModal";
import { Search } from "@/pages/Search";
import { Wanted } from "@/pages/Wanted";
import { WantedUserModal } from "@/components/_components/Modals/WantedUserModal";
import { WantedVehicleModal } from "@/components/_components/Modals/WantedVehicleModal";
import { usePermissions } from "@/providers/Permissions";

// Componente para proteger rotas
const ProtectedRoute = ({ children, pageName }: { children: React.ReactNode, pageName: string }) => {
  const { loading, canAccessPage } = usePermissions();

  if (loading) {
    return (
      <div className="flex h-full w-full items-center justify-center">
        <div className="text-white">Carregando...</div>
      </div>
    );
  }

  const hasAccess = canAccessPage(pageName);
 
  if (!hasAccess) {
    return <Navigate to="/panel" replace />;
  }

  return <>{children}</>;
};

export function Panel() {
  const location = useLocation();

  const state = location.state as { backgroundLocation?: Location };
  const backgroundLocation = state?.backgroundLocation ?? location;

  return (
    <div className="relative flex h-[35vw] w-[62vw] items-start rounded-[.8vw] border border-[#FFFFFF0D] bg-main">
      <Navigation />
      <Routes location={backgroundLocation}>
        <Route index element={<Home />} />
        <Route path="search" element={
          <ProtectedRoute pageName="search">
            <Search />
          </ProtectedRoute>
        } />
        <Route path="locked" element={
          <ProtectedRoute pageName="locked">
            <Locked />
          </ProtectedRoute>
        } />
        <Route path="fine" element={
          <ProtectedRoute pageName="fine">
            <Fine />
          </ProtectedRoute>
        } />
        <Route path="wanted" element={
          <ProtectedRoute pageName="wanted">
            <Wanted />
          </ProtectedRoute>
        } />
        <Route path="occurrence" element={
          <ProtectedRoute pageName="occurrence">
            <Occurrence />
          </ProtectedRoute>
        } />
        <Route path="members" element={
          <ProtectedRoute pageName="members">
            <Members />
          </ProtectedRoute>
        } />
      </Routes>

      <Routes>
        <Route path="modal" element={<AnnounceModal />} />
        <Route path="locked/modal" element={<PrisonModal />} />
        <Route path="fine/modal" element={<FineModal />} />
        <Route path="wanted/modalvehicle" element={<WantedVehicleModal />} />
        <Route path="wanted/modaluser" element={<WantedUserModal />} />
        <Route path="occurrence/modal" element={<OccurrenceModal />} />
        <Route path="members/modal" element={<AddMember />} />
        <Route path="members/fire" element={<FireMemberModal memberData={location.state?.memberData} />} />
      </Routes>
    </div>
  );
}
