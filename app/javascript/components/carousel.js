const carousel = () => {
  const slider = tns({
      container: '.teams-carrousel',
      items: 9,
      slideBy: 'page',
      nav: false,
      rewind: true,
      controlsText: ["<",">"]
  });
};

export { carousel };

