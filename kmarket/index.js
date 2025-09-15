const buttons = document.querySelectorAll('.mainmenu');

buttons.forEach(btn => {
  btn.addEventListener('click', () => {
    const submenu = btn.nextElementSibling;
    submenu.style.display =
      submenu.style.display === 'flex' ? 'none' : 'flex';
  });
});