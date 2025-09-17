
$(document).ready(function(){
    $('.bxslider').bxSlider({
      auto: true,       // 자동 슬라이드
      pause: 4000,      // 대기시간 (ms)
      speed: 500,       // 전환 속도
      pager: true,      // 하단 동그라미 네비게이션
      controls: true,    // 이전/다음 버튼
      adaptiveHeight: true
    });
  });



// 전체 카테고리 버튼 토글
const btn = document.getElementById("categoryBtn");
const box = document.getElementById("categoryBox");

btn.addEventListener("click", (e) => {
  e.preventDefault();
  const currentColor = getComputedStyle(btn).color; // 계산된 색상 (rgb 값 반환)
  if (currentColor === "rgb(186, 29, 29)") {        // #ba1d1d = rgb(186, 29, 29)
    btn.style.color = "black";
  } else {
    btn.style.color = "#ba1d1d";
  }
  box.style.display = (box.style.display === "flex") ? "none" : "flex";
});



// main menu hover 시 sub menu 교체
const mainItems = document.querySelectorAll(".main-menu li");
const subContents = document.querySelectorAll(".submenu-content");

mainItems.forEach(item => {
  item.addEventListener("mouseenter", () => {
    const target = item.getAttribute("data-target");
    subContents.forEach(c => {
      c.style.display = (c.id === target) ? "block" : "none";
    });
    mainItems.forEach(i => {
      i.style.background = "#eee";
      i.style.color = "black";
      i.style.fontWeight = "400";
      
    });
    item.style.background = "#1b1b1bff";
    item.style.color = "white";
    item.style.fontWeight = "bold";
  });
});
