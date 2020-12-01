const carousel = () => {
  const slider = tns({
      container: '.teams-carrousel',
      items: 5,
      slideBy: 'page',
      nav: false,
      rewind: true
  });
};

export { carousel };
