import AVFoundation

class SongsManager {
    static let shared = SongsManager()
    var audioPlayer: AVAudioPlayer?

    func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "snMusic", withExtension: "mp3") else { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 
            audioPlayer?.play()
        } catch {
            print("Could not play background music: \(error)")
        }
    }

    func stopBackgroundMusic() {
        audioPlayer?.stop()
    }
}
