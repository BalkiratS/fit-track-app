class YogaPose {
  const YogaPose({
    required this.name,
    required this.description,
    required this.imageFile,
    required this.threshold,
    required this.modelFile,
    this.descriptionImageFile,
    this.steps,
  });

  final String name;
  final String description;
  final String imageFile;
  final double threshold;
  final String modelFile;

  final String? descriptionImageFile;
  final List<String>? steps;
}

const yogaPoses = [
  YogaPose(
    name: 'Tree',
    description:
        'Grounding posture to cultivate inner balance and harmony with nature.',
    modelFile: 'tree.tflite',
    imageFile: 'images/tree.png',
    threshold: 0.5,
    descriptionImageFile: 'images/real-tree.jpeg',
    steps: [
      'Begin by standing at the top of your mat with your feet hip-width apart and your'
          'arms at your sides.',
      'Shift your weight onto your left foot and lift your right foot off the ground.'
          'Place the sole of your right foot on the inside of your left thigh, with '
          'your toes pointing downward.',
      'Press your right foot into your left thigh and your left thigh into your right '
          'foot to create a stable foundation.',
      'Bring your hands together at your heart center in a prayer position, or lift your arms'
          'above your head.',
      'Find a steady point in front of you to focus on and keep your gaze fixed on it.',
      'Hold the pose for a few breaths, focusing on your balance and stability.',
      'Release the pose by lowering your arms and lowering your right foot back to the ground.',
      'Repeat the pose on the other side, standing on your right foot and placing your '
          'left foot on your right thigh.'
    ],
  ),
  YogaPose(
    name: 'Warrior',
    description:
        'Posture of strength and courage to embody the warrior spirit within.',
    modelFile: 'warrior.tflite',
    imageFile: 'images/warrior.png',
    threshold: 5.0e-10,
    descriptionImageFile: 'images/real-warrior.jpeg',
    steps: [
      'Begin in Tadasana (Mountain Pose) with your feet hip-width apart and your arms at your sides.',
      'Step your left foot back, keeping your toes pointing towards the top of the mat.',
      'Bend your right knee, making sure it is directly above your ankle.',
      'Extend your arms out to the sides at shoulder height, palms facing down.',
      'Look over your right fingertips and hold the pose for 15-30 seconds, taking deep breaths.',
      'Exhale and straighten your right leg, lowering your arms back to your sides.',
    ],
  ),
  YogaPose(
    name: 'Downward Dog',
    description:
        'Invigorating posture that strengthens the arms and legs and create a sense'
        ' of energized calm.',
    imageFile: 'images/downward-dog.png',
    modelFile: '',
    threshold: 0,
  ),
  YogaPose(
    name: 'Cobra',
    description:
        'Heart-opening posture to strengthen the spine and rise with confidence'
        'and vitality.',
    imageFile: 'images/cobra.png',
    modelFile: '',
    threshold: 0,
  ),
  YogaPose(
    name: 'Corpse',
    description: 'Serene and meditative posture that promotes deep relaxation'
        'and spiritual renewal.',
    imageFile: 'images/corpse.png',
    modelFile: '',
    threshold: 0,
  ),
];
