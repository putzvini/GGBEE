const carousel = () => {
  const slider = tns({
      container: '.teams-carrousel',
      items: 7,
      slideBy: 'page',
      nav: false,
      rewind: true,
      controlsText: ["<",">"]
  });
};

export { carousel };

