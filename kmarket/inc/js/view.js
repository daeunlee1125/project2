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