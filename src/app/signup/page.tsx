import Content from "../../component/content";
export default function Signup() {
  return (
    <div className="flex h-screen bg-[#0c243b]">
      <div className="m-auto w-full max-w-md p-6 space-y-6 rounded-lg bg-[#2c3e50] ">
        <h1 className="text-center text-xl font-bold text-white">
          ! أهلا بك في تطبيق نادي الوثبة
        </h1>
        <Content />
      </div>
      <div className="hidden lg:block lg:w-1/2 bg-[#990707]">
        <div className="relative h-full">
          <img
            alt="ALWATHBA SPORT CLUB"
            className="absolute inset-0 h-full w-full object-cover"
            height="60"
            src="/Logo.jpg"
            width="52"
          />
        </div>
      </div>
    </div>
  );
}
