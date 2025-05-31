import { DmIcon, Icon } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { JOB2ICON } from '../common/JobToIcon';
import { Antagonist, Observable, OrbitData } from './types';

type Props = {
  item: Observable | Antagonist;
  realNameDisplay: boolean;
};

type IconSettings = {
  dmi_ref: string;
  transform: string;
};

const iconTransforms = {
  normal: 'scale(2.3) translateX(9px) translateY(1px)',
  antag: 'scale(1.8) translateX(-16px) translateY(7px)',
};

export function JobIcon(props: Props) {
  const { item, realNameDisplay } = props;
  const { data } = useBackend<OrbitData>();

  // We don't need to cast here but typescript isn't smart enough to know that
  const { icon = '', job = '', mind_icon = '', mind_job = '' } = item;
  let usedIcon = realNameDisplay ? mind_icon || icon : icon;
  let usedJob = realNameDisplay ? mind_job || job : job;

  let iconSettings: IconSettings;
  if ('antag' in item && !realNameDisplay) {
    iconSettings = {
      dmi_ref: data.icons.antag,
      transform: iconTransforms.antag,
    };
    usedJob = item.antag;
    usedIcon = item.antag_icon;
  } else {
    iconSettings = {
      dmi_ref: data.icons.normal,
      transform: iconTransforms.normal,
    };
  }

  return (
    <div className="JobIcon">
      {icon === 'borg' ? (
        <Icon color="lightblue" name={JOB2ICON[usedJob]} ml={0.3} mt={0.4} />
      ) : (
        <DmIcon
          icon={iconSettings.dmi_ref}
          icon_state={usedIcon}
          style={{
            transform: iconSettings.transform,
          }}
        />
      )}
    </div>
  );
}
