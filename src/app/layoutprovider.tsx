'use client'

import Footer from '@/component/footer';
import Header from '@/component/header';
// Use usePathname for catching route name.
import { usePathname } from 'next/navigation';
const url : string [] = ["/login" , "/resetpass" , "/setnewpass" , "/signup" , "/verification" , "/checkemail"]
const LayoutProvider = ({
    children,
  }: Readonly<{
    children: React.ReactNode;
  }>) => {
    const pathname = usePathname();
    return (
        <>
            {!url.includes(pathname)  && <Header/> }
            {children}
            {!url.includes(pathname)  && <Footer/> }
        </>
    )
};
export default LayoutProvider