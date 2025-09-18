
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


const btn = document.getElementById("categoryBtn");
const box = document.getElementById("categoryBox");

// 버튼 클릭 → 토글
btn.addEventListener("click", (e) => {
  e.preventDefault();
  e.stopPropagation(); // 이벤트 전파 막기 (document로 전달 방지)

  const currentColor = getComputedStyle(btn).color;
  if (currentColor === "rgb(113, 69, 145)") {     
    btn.style.color = "black";
  } else {
    btn.style.color = "rgb(113, 69, 145)";
  }

  // 토글
  box.style.display = (box.style.display === "flex") ? "none" : "flex";
});

// 카테고리 박스 내부 클릭 → 닫히지 않도록
box.addEventListener("click", (e) => {
  e.stopPropagation();
});

// 문서 아무 곳이나 클릭 → 닫기
document.addEventListener("click", () => {
  if (box.style.display === "flex") {
    box.style.display = "none";
    btn.style.color = "black"; // 버튼 색도 초기화
  }
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
      i.style.background = "rgb(236, 226, 236)";
      i.style.color = "black";
      i.style.fontWeight = "400";
      
    });
    item.style.background = "#3a303aff";
    item.style.color = "white";
    item.style.fontWeight = "bold";
  });
});
