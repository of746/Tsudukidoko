document.addEventListener("turbolinks:load", () => {
  const searchButton = document.getElementById("search_button");
  const queryInput = document.getElementById("book_query");
  const resultsDiv = document.getElementById("search_results");
  const coverField = document.getElementById("cover_url_field");

  if (!searchButton) return;

  searchButton.addEventListener("click", (e) => {
    e.preventDefault();
    const query = queryInput.value.trim();
    if (!query) return;

    fetch(`/seriesbooks/search_books?query=${encodeURIComponent(query)}`)
      .then(res => res.text())
      .then(html => {
        resultsDiv.innerHTML = html;

        // ラジオボタンの選択時に hidden_field に値をセット
        const radios = resultsDiv.querySelectorAll('input[name="selected_cover"]');
        radios.forEach(radio => {
          radio.addEventListener("change", () => {
            coverField.value = radio.value;
          });

          // 初期値も hidden_field に反映
          if (radio.checked) {
            coverField.value = radio.value;
          }
        });
      });
  });
});

