require 'rails_helper'

RSpec.describe Account, type: :model do

  subject { create :account }

  describe 'public instance methods' do
    context 'responds to its methods' do
      it { expect(subject).to respond_to(:role?) }
      it { expect(subject).to respond_to(:has_ssh_key?) }
      it { expect(subject).to respond_to(:enabled_two_factor_authentication?) }
      it { expect(subject).to respond_to(:activate_two_factor)}
      it { expect(subject).to respond_to(:qr_code) }
    end

    context '#role?' do
      it "user's roles" do
        user = create :user
        expect(user.role?(:user)).to eq(true)
        expect(user.role?(:admin)).to eq(false)
      end

      it "admin's roles" do
        admin = create :admin
        expect(admin.role?(:user)).to eq(false)
        expect(admin.role?(:admin)).to eq(true)
      end
    end

    context '#has_ssh_key?' do
      it 'return false' do
        user = create :user

        expect(user.has_ssh_key?).to eq(false)
      end

      it 'return true' do
        user = create :user
        create :account_ssh_key, account: user

        expect(user.has_ssh_key?).to eq(true)
      end
    end

    context '#enabled_two_factor_authentication?' do
      it 'return false' do
        user = create :user

        expect(user.enabled_two_factor_authentication?).to eq(false)
      end

      it 'return true' do
        user = create :user_with_enabled_two_factor

        expect(user.enabled_two_factor_authentication?).to eq(true)
      end
    end

    context '#activate_two_factor' do
      it 'return false' do
        user = create :user_with_enabled_two_factor

        expect(user.activate_two_factor("1214")).to eq(false)
      end

      it 'return true' do
        user = create :user_with_enabled_two_factor

        expect(user.activate_two_factor(user.current_otp)).to eq(true)
      end
    end
  end

  describe 'private instance methods' do
    context '#two_factor_otp_url' do
      it 'normal' do
        user = create :user_with_enabled_two_factor
        result = user.send(:two_factor_otp_url)

        expect(result).to eq("otpauth://totp/#{user.email}?secret=#{user.otp_secret}&issuer=SSH_Bash_Host")
      end
    end
  end
end
