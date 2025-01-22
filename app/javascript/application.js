// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Modal

document.addEventListener('DOMContentLoaded', function () {
    var modal = document.getElementById('lightbox-modal');
    var span = document.getElementsByClassName('close')[0];
  
    // Abre o modal ao clicar no link
    document.querySelectorAll('.opportunity-link').forEach(link => {
      link.addEventListener('click', function (e) {
        e.preventDefault();
  
        var opportunityId = this.dataset.opportunityId;
  
        // Faz um AJAX request para carregar a partial
        fetch(`/opportunities/${opportunityId}`)
          .then(response => response.text())
          .then(html => {
            document.getElementById('modal-body').innerHTML = html;
            modal.style.display = 'block';
          });
      });
    });
  
    // Fecha o modal ao clicar no "X"
    span.onclick = function () {
      modal.style.display = 'none';
    };
  
    // Fecha o modal clicando fora dele
    window.onclick = function (event) {
      if (event.target == modal) {
        modal.style.display = 'none';
      }
    };
  });  