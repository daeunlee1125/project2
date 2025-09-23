document.querySelectorAll("#tabMenu-2 li").forEach(tab => {
  tab.addEventListener("click", function() {
    // 1. 모든 탭 콘텐츠 숨기기
    document.querySelectorAll(".tab-content-2").forEach(c => c.style.display = "none");

    // 2. 모든 탭 비활성화
    document.querySelectorAll("#tabMenu-2 li").forEach(li => li.classList.remove("active"));

    // 3. 선택한 탭만 표시
    document.getElementById(this.dataset.target).style.display = "block";

    // 4. 탭 강조
    this.classList.add("active");
  });
});
