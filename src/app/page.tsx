import Footer from "@/component/footer";
import Header from "@/component/header";
import ImageSlider from "@/component/imageSlider";

export default function HomePage() {
  const images = ["/slider/1.jpg", "/slider/2.jpg", "/slider/3.jpg"];
  return (
    <div>
    <ImageSlider/>
    <Footer/>
    </div>
  );
}
