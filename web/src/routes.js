// import
import Dashboard from "views/Dashboard/Dashboard";
import Tables from "views/Dashboard/Tables";
import Billing from "views/Dashboard/Billing";

import {
  HomeIcon,
  StatsIcon,
  CreditIcon,
  MinecraftIcon,
} from "components/Icons/Icons";

var dashRoutes = [
  {
    path: "/home",
    name: "Home",
    icon: <HomeIcon color="inherit" />,
    component: Dashboard,
    layout: "/admin",
  },
  {
    path: "/install",
    name: "Install",
    icon: <StatsIcon color="inherit" />,
    component: Tables,
    layout: "/admin",
  },
  {
    path: "/config",
    name: "Config",
    icon: <CreditIcon color="inherit" />,
    component: Billing,
    layout: "/admin",
  },
  {
    path: "/deploy",
    name: "Deploy",
    icon: <MinecraftIcon color="inherit" />,
    component: Billing,
    layout: "/admin",
  },
  {
    path: "/mods",
    name: "Mods",
    icon: <CreditIcon color="inherit" />,
    component: Billing,
    layout: "/admin",
  },
  {
    path: "/faq",
    name: "FAQ",
    icon: <CreditIcon color="inherit" />,
    component: Billing,
    layout: "/admin",
  },
  {
    path: "/about",
    name: "About",
    icon: <CreditIcon color="inherit" />,
    component: Billing,
    layout: "/admin",
  },
  {
    path: "/contact",
    name: "Contacto",
    icon: <CreditIcon color="inherit" />,
    component: Billing,
    layout: "/admin",
  },
];
export default dashRoutes;
