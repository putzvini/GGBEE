const carousel = () => {
  const slider = tns({
      container: '.teams-carrousel',
      items: 6,
      slideBy: 'page',
      nav: false,
      rewind: true
  });
};

export { carousel };
