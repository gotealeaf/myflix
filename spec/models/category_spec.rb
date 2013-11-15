require 'spec_helper'

describe Category do
  it { should have_many(:videos) }

  describe '#recent_videos' do
    let(:tv_drama) { Fabricate(:category) }
    let(:subject) { tv_drama.recent_videos }

    context 'most recent created_at order' do
      before do
        @breaking_bad = Fabricate(:video, category: tv_drama, created_at: 1.day.ago)
        @walking_dead = Fabricate(:video, category: tv_drama)
      end
      it { expect(subject).to eq([@walking_dead, @breaking_bad]) }
    end

    context 'less than or equal to 6 videos' do
      before do
        breaking_bad = Fabricate(:video, category: tv_drama, created_at: 1.day.ago)
        walking_dead = Fabricate(:video, category: tv_drama)
      end
      it { expect(subject.count).to eq(2) }
    end

    context 'more than 6 videos' do
      before do
        7.times.each do
          Fabricate(:video, category: tv_drama)
        end
      end
      it { expect(subject.count).to eq(6) }
    end

    context 'most 6 recent videos' do
      before do
        6.times.each do
          Fabricate(:video, category: tv_drama)
        end
        @greys_anatomy = Fabricate(:video, category: tv_drama, created_at: 1.day.ago)
      end
      it { expect(subject).not_to include(@greys_anatomy) }
    end

    context 'no videos' do
      it { expect(subject).to eq([]) }
    end
  end
end