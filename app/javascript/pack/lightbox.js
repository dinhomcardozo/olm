document.addEventListener('DOMContentLoaded', () => {
  // Funcionalidade para abrir o lightbox
  document.querySelectorAll('.opportunity-link').forEach(link => {
    link.addEventListener('click', event => {
      event.preventDefault();
      const lightboxUrl = link.dataset.lightboxUrl;

      fetch(lightboxUrl, { headers: { 'X-Requested-With': 'XMLHttpRequest' } })
        .then(response => response.text())
        .then(html => {
          const lightbox = document.getElementById('opportunity-lightbox');
          lightbox.innerHTML = html;
          lightbox.style.display = 'block';
          // Chama a função para configurar os eventos de produtos
          setupProductRows();
        })
        .catch(error => console.error('Erro ao carregar o lightbox:', error));
    });
  });

  // Função para configurar os campos de produto, quantidade, preço unitário e total
  const setupProductRows = () => {
    const productRows = document.querySelectorAll(".product-row");

    productRows.forEach(row => {
      const productSelect = row.querySelector(".product-select");
      const quantityInput = row.querySelector(".product-quantity");
      const unitPriceInput = row.querySelector(".product-unit-price");
      const totalPriceInput = row.querySelector(".product-total-price");

      // Inicializar o select2 para o campo de produto
      $(productSelect).select2({
        placeholder: "Selecione um produto",
        allowClear: true,
        ajax: {
          url: '/produtos',  // Modifique a URL conforme necessário
          dataType: 'json',
          processResults: function(data) {
            return {
              results: data.map(product => ({
                id: product.product_id,
                text: `${product.product_description} (${product.product_brand})`,
                price: product.product_price
              }))
            };
          }
        }
      });

      // Atualizar preço unitário ao selecionar produto
      productSelect.addEventListener("change", () => {
        const selectedOption = productSelect.options[productSelect.selectedIndex];
        const unitPrice = parseFloat(selectedOption.dataset.price) || 0;
        unitPriceInput.value = unitPrice.toFixed(2);
        updateTotal();
      });

      // Atualizar preço total ao alterar quantidade
      quantityInput.addEventListener("input", () => {
        updateTotal();
      });

      // Função para atualizar o preço total com base na quantidade e no preço unitário
      const updateTotal = () => {
        const quantity = parseInt(quantityInput.value) || 0;
        const unitPrice = parseFloat(unitPriceInput.value) || 0;
        totalPriceInput.value = (quantity * unitPrice).toFixed(2);
      };
    });
  };
});