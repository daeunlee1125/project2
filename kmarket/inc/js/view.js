$(document).ready(function() {
const basePrice = parseInt($('.product-info-section').data('product-price'));

// 색상 또는 사이즈 선택 시 이벤트 처리
$('#select-color, #select-size').on('change', function() {
    const color = $('#select-color').val();
    const size = $('#select-size').val();

    // 색상과 사이즈가 모두 선택되었는지 확인
    if (color && size) {
        const optionText = `베이직 레더 벨트 / ${color} / ${size}`;
        
        // 이미 추가된 옵션인지 확인
        let isDuplicate = false;
        $('.selected-item').each(function() {
            if ($(this).find('.item-name').text() === optionText) {
                isDuplicate = true;
            }
        });

        if (isDuplicate) {
            alert('이미 추가된 옵션입니다.');
        } else {
            // 선택된 상품 HTML 생성
            const newItemHtml = `
                <div class="selected-item">
                    <span class="item-name">${optionText}</span>
                    <div class="quantity-counter">
                        <button class="btn-minus">-</button>
                        <input type="text" class="quantity-input" value="1" readonly>
                        <button class="btn-plus">+</button>
                    </div>
                    <span class="item-total-price">${basePrice.toLocaleString()}원</span>
                    <button class="btn-remove">×</button>
                </div>`;
            
            $('#selected-options-list').append(newItemHtml);
        }

        // 선택 후 드롭다운 초기화
        $('#select-color').val('');
        $('#select-size').val('');
        
        // 총 금액 업데이트
        updateGrandTotal();
    }
});

// 수량 변경 및 삭제 버튼 이벤트 (이벤트 위임)
$('#selected-options-list').on('click', 'button', function() {
    const $item = $(this).closest('.selected-item');
    const $quantityInput = $item.find('.quantity-input');
    let quantity = parseInt($quantityInput.val());

    if ($(this).hasClass('btn-plus')) {
        quantity++;
    } else if ($(this).hasClass('btn-minus')) {
        if (quantity > 1) {
            quantity--;
        }
    } else if ($(this).hasClass('btn-remove')) {
        $item.remove();
    }

    $quantityInput.val(quantity);
    updateGrandTotal();
});

// 총 금액 계산 및 업데이트 함수
function updateGrandTotal() {
    let grandTotal = 0;
    $('.selected-item').each(function() {
        const $item = $(this);
        const quantity = parseInt($item.find('.quantity-input').val());
        const itemTotal = basePrice * quantity;
        
        // 개별 항목 가격 업데이트
        $item.find('.item-total-price').text(itemTotal.toLocaleString() + '원');
        
        grandTotal += itemTotal;
    });
    
    // 최종 합계 금액 업데이트
    $('#grand-total-price').text(grandTotal.toLocaleString() + '원');
}
});


$(document).ready(function() {
    
    // ==========================================================
    // 1. 상세정보 펼치기/접기 기능
    // ==========================================================
    $('.toggle-detail-btn').on('click', function() {
        const $container = $('.long-detail-container');
        const $button = $(this);

        $container.toggleClass('expanded');

        if ($container.hasClass('expanded')) {
            $button.text('상세정보 접기 ▲');
        } else {
            $button.text('상세정보 펼쳐보기 ▼');
        }
        
        // ★★★ 변경점: 펼치거나 접은 후 섹션 위치를 다시 계산
        recalculateOffsets();
    });

    // ==========================================================
    // 2. Sticky 네비게이션 & Scrollspy 기능
    // ==========================================================
    const $nav = $('.product-detail-nav');
    if ($nav.length) {
        
        const $navLinks = $nav.find('a');
        const $navItems = $nav.find('li');
        const $placeholder = $('.nav-placeholder');
        let navOffsetTop = $nav.offset().top; // 초기 위치
        const navHeight = $nav.outerHeight();
        
        let isAnimating = false;
        let sectionOffsets = []; // 섹션 위치 정보를 담을 배열

        $placeholder.height(navHeight);

        // ★★★ 변경점: 섹션 위치 계산 로직을 별도 함수로 분리
        function recalculateOffsets() {
            sectionOffsets = []; // 배열 초기화
            $navLinks.each(function() {
                const targetId = $(this).attr('href');
                const $target = $(targetId);
                if ($target.length) {
                    sectionOffsets.push({
                        id: targetId,
                        top: $target.offset().top
                    });
                }
            });
            // 네비게이션의 원래 위치도 다시 계산 (필요 시)
            navOffsetTop = $nav.offset().top;
        }

        recalculateOffsets(); // 페이지 로드 시 최초 1회 계산

        $(window).on('scroll', function() {
            const scrollTop = $(this).scrollTop();

            if (scrollTop >= navOffsetTop) {
                $nav.addClass('sticky');
                $placeholder.show();
            } else {
                $nav.removeClass('sticky');
                $placeholder.hide();
            }
            
            if (!isAnimating) {
                updateActiveNav(scrollTop);
            }
        });

        function updateActiveNav(scrollTop) {
            let currentSectionId = null;
            const scrollPosition = scrollTop + navHeight + 20;

            for (const section of sectionOffsets) {
                if (scrollPosition >= section.top) {
                    currentSectionId = section.id;
                }
            }
            
            $navItems.removeClass('active');
            if (currentSectionId) {
                $nav.find(`a[href="${currentSectionId}"]`).parent('li').addClass('active');
            }
        }

        $navLinks.on('click', function(e) {
            e.preventDefault();
            
            const targetId = $(this).attr('href');
            const $target = $(targetId);

            if ($target.length) {
                isAnimating = true;
                
                // 클릭 시점의 정확한 위치를 위해 offset을 다시 계산할 수 있음
                const scrollToPosition = $target.offset().top - navHeight;
                
                $navItems.removeClass('active');
                $(this).parent('li').addClass('active');

                $('html, body').stop().animate({
                    scrollTop: scrollToPosition
                }, 500, function() {
                    isAnimating = false;
                });
            }
        });
    }
});