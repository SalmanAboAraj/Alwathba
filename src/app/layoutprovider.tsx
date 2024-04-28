'use client'

// Use usePathname for catching route name.
import { usePathname } from 'next/navigation';
const LayoutProvider = ({
    children,
  }: Readonly<{
    children: React.ReactNode;
  }>) => {
    const pathname = usePathname();
    return (
        <>
            {/* {pathname === "/login" && <h1>Welcome to Posts page!</h1>} */}
            {children}
        </>
    )
};
export default LayoutProvider