const carousel = () => {
  const slider = tns({
      container: '.teams-carrousel',
      items: 4,
      slideBy: 'page',
      nav: false,
      rewind: true
  });
};

export { carousel };
