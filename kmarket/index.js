


// 전체 카테고리 버튼 토글
const btn = document.getElementById("categoryBtn");
const box = document.getElementById("categoryBox");

btn.addEventListener("click", (e) => {
  e.preventDefault();
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
